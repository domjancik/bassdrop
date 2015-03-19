class Artist < ActiveRecord::Base
  belongs_to :city

  has_many :performances
  has_many :events, -> { uniq }, through: :performances

  def to_s
    title
  end
end
