class StoryPolicy < ApplicationPolicy
  def can_modify?
    is_vip?
  end

  class Scope < Scope
    def resolve
      is_vip? ? scope : scope.published
    end
  end
end
