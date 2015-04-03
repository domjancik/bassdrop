class Medium < ActiveRecord::Base
  NOEMBED_URL = 'http://noembed.com/embed'

  def oembed_info(extra_params = {})
    params = { url: self.url }
    params.merge! extra_params
    response = RestClient.get NOEMBED_URL, {params: params}
    JSON.parse response
  end
end
