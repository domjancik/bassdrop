class Venue < ActiveRecord::Base
  has_many :events
  validates :venue, presence: true

  def to_s
    title
  end
end
