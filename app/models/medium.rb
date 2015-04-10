class Medium < ActiveRecord::Base
  NOEMBED_URL = 'http://noembed.com/embed'

  belongs_to :release

  def oembed_info(extra_params = {})
    params = { url: self.url }
    params.merge! extra_params
    response = RestClient.get NOEMBED_URL, {params: params}
    JSON.parse response
  end

  def to_s
    self.title
  end

  def fill_blanks!
    info = oembed_info
    self.title = info['title'] if self.title.blank?
    self.description = info['description'] if self.description.blank?
    save
  end
end
