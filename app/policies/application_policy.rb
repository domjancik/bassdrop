class ApplicationPolicy
  attr_reader :user, :record

  def can_modify?
    is_admin?
  end

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    can_modify?
  end

  def create_playlist?
    can_modify?
  end

  def new?
    create?
  end

  def update?
    can_modify?
  end

  def publish?
    can_modify?
  end

  def hide?
    can_modify?
  end

  def edit?
    update?
  end

  def destroy?
    can_modify?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  def is_admin?
    return false if @user.nil?
    @user.admin?
  end

  def is_vip?
    return false if @user.nil?
    @user.vip? || @user.admin?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def is_admin?
      return false if @user.nil?
      @user.admin?
    end

    def is_vip?
      return false if @user.nil?
      @user.vip? || @user.admin?
    end

    def resolve
      scope
    end
  end
end

