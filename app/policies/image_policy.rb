class ImagePolicy < ApplicationPolicy
  def can_modify?
    is_vip?
  end

  def reveal?
    true
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
