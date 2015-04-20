class VisitorsController < ApplicationController
  helper SocialHelper
  helper WelcomeHelper
  helper TimeFormatHelper

  def index
    redirect_to '//bassdrop.cz' if request.host == 'bassdrop.herokuapp.com'

    @next_event = policy_scope(Event).next
    @upcoming_events = policy_scope(Event.upcoming.limit(5).offset(1))
    stories = (policy_scope Story.all)
    @stories = stories.limit(3)
    @more_stories = stories.count > 3
  end
end
