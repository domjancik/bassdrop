class Release < ActiveRecord::Base
  enum release_type: [:other, :set_audio, :set_video, :record, :trailer, :aftermovie]

  validates :title, presence: true

  has_many :credits
  has_many :artists, through: :credits
  belongs_to :playlist

  def to_s
    title
  end

  def image_url
    # TODO
    case release_type
      when 'record'
        return 'default_image_records.jpg'
      when 'set_audio', 'set_video'
        return image_url_mix
    end

    'default_image.jpg'
  end

  private
    def image_url_mix
      return artists.take.image_url unless artists.empty?

      'default_image_records.jpg'
    end
end
