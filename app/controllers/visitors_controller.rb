class VisitorsController < ApplicationController
  helper SocialHelper
  helper WelcomeHelper
  helper TimeFormatHelper

  def index
    redirect_to '//bassdrop.cz' if request.host == 'bassdrop.herokuapp.com'

    @next_event = policy_scope(Event).next
    @upcoming_events = policy_scope(Event.upcoming.limit(5))
    stories = (policy_scope Story.all)
    @stories = stories.limit(3)
    @more_stories = stories.count > 3
    @artists = policy_scope(Artist.featured.limit(2))

    @records = policy_scope(Release.record.limit(1))
    @videos = policy_scope(Release.videos.limit(1))
    @sets = policy_scope(Release.sets.limit(1))

    @release_order = []
    begin
      @release_order << { date: @records.take!.release_date, type: :records }
    rescue
    end

    begin
      @release_order << { date: @sets.take!.release_date, type: :sets }
    rescue
    end

    begin
      @release_order << { date: @videos.take!.release_date, type: :videos }
    rescue
    end

    (@release_order.sort_by! { |e| e[:date] }).reverse!
  end
end
