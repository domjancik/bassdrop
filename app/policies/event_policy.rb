class EventPolicy < ApplicationPolicy
  def year?
    true
  end

  class Scope < Scope
    def resolve
      is_admin? ? scope : scope.where(published: true)
    end
  end
end
