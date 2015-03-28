class VisitorsController < ApplicationController
  def index
    @next_event = policy_scope(Event.next)
    @upcoming_events = policy_scope(Event.upcoming.limit(5).offset(1))
  end
end
