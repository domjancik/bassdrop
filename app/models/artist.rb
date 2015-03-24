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
end
