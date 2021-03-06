class Release < ActiveRecord::Base
  include Avatarable
  include DescriptionLocalizable
  include StringIDable

  enum release_type: [:other, :set_audio, :set_video, :record, :trailer, :aftermovie]

  validates :title, presence: true
  validates :rel_code, presence: true

  default_scope { order('release_date desc') }

  has_many :credits
  has_many :artists, -> { select('artists.*, credits.list_order') }, through: :credits
  has_many :main_artists, -> { select('artists.*, credits.list_order').where('credits.title IS NULL OR CHAR_LENGTH(credits.title) = 0').uniq }, through: :credits, source: :artist
  belongs_to :playlist
  has_many :stories, -> { published }

  scope :videos, -> { where('release_type = ? OR release_type = ?', release_types['trailer'], release_types['aftermovie']) }
  scope :sets, -> { where('release_type = ? OR release_type = ?', release_types['set_audio'], release_types['set_video']) }

  def to_s
    title
  end

  def in_future?
    return true if release_date.blank?
    Time.now < release_date
  end

  # Next release in category
  def next
    Release.where('release_date > ? AND release_type = ?', release_date, Release.release_types[release_type]).last
  end

  # Previous release in category
  def prev
    Release.where('release_date < ? AND release_type = ?', release_date, Release.release_types[release_type]).first
  end

  def image_urls(style, include_own = false)
    avatars = []
    avatars << avatar.url(style) if include_own && !avatar_file_name.nil?
    main_artists.select('artists.*, RANDOM() as rand').reorder('rand').each { |artist| avatars << artist.image_url(style) }
    avatars
  end

  def has_avatar?
    not avatar_file_name.nil?
  end

  private

    def image_missing_url(style)
      case release_type
        when 'record'
          return 'default_image_records.jpg'
        when 'set_audio', 'set_video'
          return image_url_artist(style) || 'default_image_records.jpg'
        when 'trailer', 'aftermovie'
          return image_url_artist(style) || 'default_image.jpg'
      end

      'default_image.jpg'
    end

    # Default image for a mix is it's main artist's avatar
    def image_url_artist(style)
      return main_artists.take.image_url(style) unless main_artists.empty?
      nil
    end
end
