require 'net/http'
require 'json'

class Artist < ActiveRecord::Base
  include Avatarable
  include DescriptionLocalizable
  include StringIDable
  
  enum role: [:artist, :supported, :headliner, :bassdrop, :records, :creator]
  # default_scope { order('role desc') }

  belongs_to :city
  belongs_to :country
  belongs_to :playlist

  has_many :performances
  has_many :events, -> { uniq }, through: :performances
  has_many :credits
  has_many :releases, through: :credits
  has_many :stories, -> { published }
  has_many :authored_stories, class_name: 'Story', foreign_key: 'author_id'

  validates :country, presence: true
  validates :title, presence: true
  validates_with CityCountryValidator

  def to_s
    title
  end

  def released_record!
    self.released_record = true
    save
  end

  def self.released_record
    Artist.where(released_record: true)
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

  def social_links
    links = []

    add_link = lambda do |service_url, link, name|
      links << { name: name, url: "#{service_url}/#{link}" } unless link.blank?
    end

    add_link.call 'https://www.facebook.com', link_fb, 'facebook'
    add_link.call 'https://www.soundcloud.com', link_soundcloud, 'soundcloud'
    add_link.call 'https://www.youtube.com', link_youtube, 'youtube'
    add_link.call 'https://www.instagram.com', link_instagram, 'instagram'
    add_link.call 'https://www.twitter.com', link_twitter, 'twitter'

    links
  end

  private
    def image_missing_url(style)
      refresh_image_cache # TODO move call to background
      image_url_cached ? image_url_cached : 'default_image.jpg'
    end
end
