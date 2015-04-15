class ImagePolicy < ApplicationPolicy
  def reveal?
    true
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
