require 'rest_client'
require 'json'

namespace :db do
  desc 'Download BASS DROP events from facebook (Basic data only)'
  task loadevents: :environment do
    page_id = 'bassdropcz'

    params = {access_token: FacebookHelper.access_token}

    response =  RestClient.get "#{FacebookHelper.graph_url}/#{page_id}/events", {params: params}
    json_response = JSON.parse(response)
    add_events json_response

    while json_response['paging'].has_key? 'next'
      next_page = json_response['paging']['next']
      response = RestClient.get next_page
      json_response = JSON.parse(response)
      add_events json_response
    end

    puts 'Loaded FB Events (Basic info), call db:fillevents to load the rest'
  end

  private

  def add_events(json_response)
    json_response['data'].each do |fb_event|
      title = fb_event['name']

      begin
        date_start = fb_event['start_time']
        link_fb = fb_event['id']
        event = Event.new({title: title, date_start: date_start, link_fb: link_fb})
        event.date_end = fb_event['end_time'] if fb_event.has_key? 'end_time'
        event.save
        puts 'Loaded ' + event
      rescue ActiveRecord::RecordNotUnique
        puts 'Already in DB: ' + title
      end
    end
  end

  desc 'Download additional data for events from facebook'
  task fillevents: :environment do
    Event.all.each { |event| event.update_from_fb }
  end
end
