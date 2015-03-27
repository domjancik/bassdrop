module FacebookHelper
  def self.access_token
    app_id = ENV['facebook_app_id']
    app_secret = ENV['facebook_secret']
    "#{app_id}|#{app_secret}"
  end

  def self.graph_url
    'https://graph.facebook.com/v2.3'
  end
end