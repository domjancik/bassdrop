class Release < ActiveRecord::Base
  include Avatarable

  enum release_type: [:other, :set_audio, :set_video, :record, :trailer, :aftermovie]

  validates :title, presence: true
  validates :rel_code, presence: true

  default_scope { order('release_date desc') }

  has_many :credits
  has_many :artists, through: :credits
  has_many :main_artists, -> { where('credits.title IS NULL OR CHAR_LENGTH(credits.title) = 0').uniq }, through: :credits, source: :artist
  belongs_to :playlist
  has_many :stories, -> { published }

  def to_s
    title
  end

  def in_future?
    return true if release_date.blank?
    Time.now < release_date
  end

  private
    def image_missing_url
      case release_type
        when 'record'
          return 'default_image_records.jpg'
        when 'set_audio', 'set_video'
          return image_url_artist || 'default_image_records.jpg'
        when 'trailer', 'aftermovie'
          return image_url_artist || 'default_image.jpg'
      end

      'default_image.jpg'
    end

    # Default image for a mix is it's main artist's avatar
    def image_url_artist
      return main_artists.take.image_url unless main_artists.empty?
      nil
    end
end
