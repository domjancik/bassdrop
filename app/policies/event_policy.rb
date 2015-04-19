class EventPolicy < ApplicationPolicy
  def year?
    true
  end

  def next
    true
  end

  def can_modify?
    is_vip?
  end

  class Scope < Scope
    def resolve
      is_admin? ? scope : scope.where(published: true)
    end
  end
end
