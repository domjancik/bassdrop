class VisitorsController < ApplicationController
  helper SocialHelper
  helper WelcomeHelper
  helper TimeFormatHelper

  def index
    redirect_to 'https://bassdrop-assets.s3.amazonaws.com/pages/maintenance/index.html' if request.host == 'bassdrop.cz' || request.host == 'www.bassdrop.cz'

    @next_event = policy_scope(Event).next
    @upcoming_events = policy_scope(Event.upcoming.limit(5).offset(1))
    @stories = policy_scope Story.all.limit(3)
  end
end
