require 'json'

class Event < ActiveRecord::Base
  default_scope { order('events.date_start desc') }

  belongs_to :venue
  belongs_to :playlist

  has_many :performances, -> { order(:stage_id) }, dependent: :destroy

  has_many :stages, -> { uniq }, through: :performances

  has_many :artists, -> { uniq }, through: :performances
  has_many :headliners, -> { where(:performances => {is_headliner: true}).uniq },
           through: :performances, :source => :artist
  has_many :non_headliners, -> { where(:performances => {is_headliner: false}) },
           through: :performances, :source => :artist

  scope :upcoming, -> { where('events.date_start > ?', 12.hours.ago).reorder('events.date_start asc') }
  scope :past, -> { where('events.date_start <= ?', 12.hours.ago) }
  scope :past_year, ->(year) { past.where('YEAR(events.date_start) = ?', year) }

  def to_s
    title
  end

  def to_str
    title
  end

  def stage_lineup(stage)
    lineup.where(stage: stage)
  end

  def lineup
    performances.order :date_start
  end

  def attending_count
    self.read_attribute :attending_count
  end

  # True if the event spans more than one day
  def spans_more_days?
    return false if self.date_end.nil?
    return false if self.date_end - self.date_start < 12.hours
    true
  end

  def update_from_fb
    fb_event = FacebookHelper.fetch_fb_event link_fb, 'description,cover,place'

    self.venue = Venue.from_fb_json fb_event['place'] if fb_event.has_key? 'place'

    self.description = fb_event['description'] if fb_event.has_key? 'description'
    self.image_url_cached = fb_event['cover']['source'] if fb_event.has_key? 'cover'

    self.cached_at = Time.now

    self.save
  end

  def seconds_since_stat_update
    return Float::INFINITY if stats_updated_at.nil?
    Time.now - stats_updated_at
  end

  # Update attending count and possibly more in the future
  def update_stats
    return unless TimeHelper.older_hours stats_updated_at, 12

    fb_event = FacebookHelper.fetch_fb_event link_fb, 'attending_count'
    self.attending_count = fb_event['attending_count']

    self.stats_updated_at = Time.now
    self.save
  end

  def self.next
    self.upcoming.take
  end
end
