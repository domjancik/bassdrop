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
    end

    'default_image.jpg'
  end
end
