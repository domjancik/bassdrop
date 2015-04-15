class ImagePolicy < ApplicationPolicy
  def reveal?
    true
  end

  def edit?
    is_vip?
  end

  def new?
    is_vip?
  end

  def create?
    is_vip?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
