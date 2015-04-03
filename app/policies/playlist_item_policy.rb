class PlaylistItemPolicy < ApplicationPolicy
  def open?
    true
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
