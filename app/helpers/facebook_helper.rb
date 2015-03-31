module FacebookHelper
  GRAPH_URL = 'https://graph.facebook.com/v2.3'
  HOME_URL = 'https://www.facebook.com'

  def self.access_token
    app_id = ENV['facebook_app_id']
    app_secret = ENV['facebook_secret']
    "#{app_id}|#{app_secret}"
  end

  def self.graph_url
    GRAPH_URL
  end

  def fb_link(fb_id)
    HOME_URL + '/' + fb_id
  end
end