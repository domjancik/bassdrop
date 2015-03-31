class Performance < ActiveRecord::Base
  validates :event, presence: true
  validates :artist, presence: true
  validates_with PerformanceStageValidator

  belongs_to :event
  belongs_to :artist
  belongs_to :stage
end
