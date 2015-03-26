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
    return nil if link_fb.nil?

    url = "http://graph.facebook.com/v2.3/#{link_fb}/picture?redirect=false&type=large"
    resp = Net::HTTP.get_response(URI.parse(url))

    data = resp.body
    fb_data = JSON.parse(data)['data']

    return nil if fb_data.nil?

    fb_data['url']
  end
end
