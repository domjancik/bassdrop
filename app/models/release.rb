class Release < ActiveRecord::Base
  has_many :media, through: :release_mediums
  has_many :credits
end
