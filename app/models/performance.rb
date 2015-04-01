class Performance < ActiveRecord::Base
  validates :event, presence: true
  validates :artist, presence: true
  validates_with PerformanceStageValidator

  belongs_to :event
  belongs_to :artist
  belongs_to :stage

  has_many :b2bs, class_name: 'Performance', foreign_key: 'b2b_id'
  belongs_to :b2b, class_name: 'Performance'
end
