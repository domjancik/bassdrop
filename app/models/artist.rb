require 'net/http'
require 'json'

class Artist < ActiveRecord::Base
  belongs_to :city
  belongs_to :country

  has_many :performances
  has_many :events, -> { uniq }, through: :performances

  validates :country, presence: true
  validates :title, presence: true
  validates_with CityCountryValidator

  def to_s
    title
  end

  def image_url
    refresh_image_cache # TODO move call to background
    image_url_cached
  end

  def seconds_since_image_cache
    return Float::INFINITY if image_url_cached_at.nil?
    Time.now - image_url_cached_at
  end

  def refresh_image_cache
    return if seconds_since_image_cache < 60 * 60 * 24 * 10
    return if link_fb.nil?

    url = "http://graph.facebook.com/v2.3/#{link_fb}/picture?redirect=false&type=large"
    resp = Net::HTTP.get_response(URI.parse(url))

    data = resp.body
    fb_data = JSON.parse(data)['data']

    return nil if fb_data.nil?

    self.image_url_cached = fb_data['url']
    self.image_url_cached_at = Time.now
    save
  end
end
