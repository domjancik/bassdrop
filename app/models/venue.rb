class Venue < ActiveRecord::Base
  has_many :events
  validates :title, presence: true

  def to_s
    title
  end
end
