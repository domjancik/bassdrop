class ArtistPolicy < ApplicationPolicy
  def can_modify?
    is_vip?
  end

  def destroy?
    is_admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
