class ReleasePolicy < ApplicationPolicy

  def avatars?
    true
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
