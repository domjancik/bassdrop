class Release < ActiveRecord::Base
  enum type: [:other, :mix_audio, :mix_video, :record, :trailer, :aftermovie]

  has_many :credits
end
