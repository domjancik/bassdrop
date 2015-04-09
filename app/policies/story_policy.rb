class StoryPolicy < ApplicationPolicy
  def edit?
    is_vip?
  end

  def hide?
    is_vip?
  end

  def publish?
    is_vip?
  end

  def new?
    is_vip?
  end

  def create?
    is_vip?
  end


  def create_playlist?
    is_vip?
  end

  class Scope < Scope
    def resolve
      is_vip? ? scope : scope.published
    end
  end
end
