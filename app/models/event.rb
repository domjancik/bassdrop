class Event < ActiveRecord::Base
  belongs_to :venue

  has_many :performances
  has_many :artists, -> { uniq }, through: :performances

  def to_s
    title
  end
end
