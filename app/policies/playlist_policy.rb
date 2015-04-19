class PlaylistPolicy < ApplicationPolicy
  def open?
    true
  end

  def can_modify?
    is_vip?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
