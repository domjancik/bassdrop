module FacebookHelper
  GRAPH_URL = 'https://graph.facebook.com/v2.3'
  HOME_URL = 'https://www.facebook.com'

  def self.access_token
    app_id = Rails.application.secrets.facebook_app_id
    app_secret = Rails.application.secrets.facebook_secret
    "#{app_id}|#{app_secret}"
  end

  def self.graph_url
    GRAPH_URL
  end

  def fb_link(fb_id)
    HOME_URL + '/' + fb_id
  end

  def self.fetch_fb_event(event_id, fields)
    params = {access_token: FacebookHelper.access_token, fields: fields}
    response =  RestClient.get "#{FacebookHelper.graph_url}/#{event_id}", {params: params}
    JSON.parse response
  end
end