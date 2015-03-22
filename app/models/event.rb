class Event < ActiveRecord::Base
  belongs_to :venue

  has_many :performances, -> { order(:stage_id) }

  has_many :stages, -> { uniq }, through: :performances

  has_many :artists, -> { uniq }, through: :performances
  has_many :headliners, -> { where(:performances => {is_headliner: true}).uniq },
           through: :performances, :source => :artist
  has_many :non_headliners, -> { where(:performances => {is_headliner: false}) },
           through: :performances, :source => :artist

  def to_s
    title
  end

  def stage_lineup(stage)
    lineup.where(stage: stage)
  end

  def lineup
    performances.order :date_start
  end
end
