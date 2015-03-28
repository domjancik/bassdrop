class VisitorsController < ApplicationController
  def index
    @next_event = Event.next
    @upcoming_events = Event.upcoming.limit(5).offset(1)
  end
end
