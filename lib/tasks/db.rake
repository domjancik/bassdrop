require 'rest_client'
require 'json'

namespace :db do
  desc "Download BASS DROP events from facebook (Basic data only)"
  task loadevents: :environment do
    fb_graph_url = 'https://graph.facebook.com'

    page_id = 'bassdropcz'

    params = {access_token: access_token}

    response =  RestClient.get "#{fb_graph_url}/#{page_id}/events", {params: params}
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
      date_start = fb_event['start_time']
      link_fb = fb_event['id']
      event = Event.new({title: title, date_start: date_start, link_fb: link_fb})
      event.date_end = fb_event['end_time'] if fb_event.has_key? 'end_time'

      event.save
      puts 'Loaded ' + event
    end
  end

  def access_token
    app_id = ENV['facebook_app_id']
    app_secret = ENV['facebook_secret']
    "#{app_id}|#{app_secret}"
  end

end
