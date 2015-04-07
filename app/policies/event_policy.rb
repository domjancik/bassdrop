class EventPolicy < ApplicationPolicy
  def publish?
    is_admin?
  end

  def hide?
    is_admin?
  end

  class Scope < Scope
    def resolve
      is_admin? ? scope : scope.where(published: true)
    end
  end
end
