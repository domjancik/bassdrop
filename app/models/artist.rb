require 'net/http'
require 'json'

class Artist < ActiveRecord::Base
  enum role: [:artist, :supported, :headliner, :bassdrop]
  default_scope { order('role desc') }

  belongs_to :city
  belongs_to :country
  belongs_to :playlist

  has_many :performances
  has_many :events, -> { uniq }, through: :performances
  has_many :releases

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

  def fb_image_url
    FacebookHelper.fb_profile_picture_url link_fb
  end

  def refresh_image_cache
    return unless TimeHelper.older_days image_url_cached_at, 10
    return if link_fb.nil?
    force_refresh_image_cache
  end

  def force_refresh_image_cache
    self.image_url_cached = fb_image_url
    self.image_url_cached_at = Time.now
    save
  end
end
