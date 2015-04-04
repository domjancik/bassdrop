module FacebookHelper
  GRAPH_URL = 'https://graph.facebook.com'
  HOME_URL = 'https://www.facebook.com'
  GRAPH_VERSION = 'v2.3'

  def self.access_token
    app_id = Rails.application.secrets.facebook_app_id
    app_secret = Rails.application.secrets.facebook_secret
    "#{app_id}|#{app_secret}"
  end

  def fb_link(fb_id)
    HOME_URL + '/' + fb_id
  end

  # @param [String] url the variable part of graph url, without leading slash
  # @param [String] version Graph API version to use, defaults to latest
  # @param [Hash] Extra params to add to the request, defaults to nil
  def self.request(url, params = nil, version = GRAPH_VERSION )
    graph_url = "#{GRAPH_URL}/"
    graph_url << "#{version}/" unless version.nil?
    get_url = "#{graph_url}#{url}"

    # puts graph_url
    # puts params

    begin
      response =  RestClient.get get_url, {params: params}
      JSON.parse response
    rescue RestClient::ResourceNotFound => ex
      JSON.parse ex.http_body
    end
  end

  def self.request_authorized(url, params = nil, version = GRAPH_VERSION)
    auth_params = { access_token: access_token }
    auth_params.merge! params unless params.nil?
    request url, auth_params, version
  end

  def self.fetch_fb_event(event_id, fields)
    request_authorized event_id, { fields: fields }
  end

  def self.fb_profile_picture_url(id)
    return nil if id.nil?

    params = { type: 'large', redirect: 'false' }

    response = request id + '/picture', params

    return nil if response.nil?
    return fb_user_profile_picture_url(id) if is_error? response, 803

    response['data']['url']
  end

  private
    # @return [Hash] Parsed jason response to a user profile pic request
    def self.fb_user_profile_picture_url(id)
      response = request id, { fields: 'id' }, nil # Unversioned request to catch user ID
      user_id = response['id']

      return nil if user_id.nil?

      response = request_authorized user_id + '/picture', params = { type: 'large', redirect: 'false' }
      image_url = response['data']['url']
      return image_url if is_square? image_url

      response = request_authorized user_id + '/picture', params = { type: 'square', redirect: 'false' }
      response['data']['url']
    end

    def self.is_square?(image_url)
      size = FastImage.size(image_url)
      size[0] == size[1]
    end

    def self.is_error?(response, err_code)
      response.has_key?('error') && (not /##{err_code}/.match(response['error']['message']).nil?)
    end
end
