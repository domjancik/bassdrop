module TimeHelper
  SECONDS_IN_MINUTE = 60
  SECONDS_IN_HOUR = SECONDS_IN_MINUTE * 60
  SECONDS_IN_DAY = SECONDS_IN_HOUR * 24

  def in_future?(date)
    date > ::Time.now
  end

  def self.days_to_seconds(days)
    days * SECONDS_IN_DAY
  end

  def self.hours_to_seconds(hours)
    hours * SECONDS_IN_HOUR
  end

  def self.minutes_to_seconds(minutes)
    minutes * SECONDS_IN_MINUTE
  end

  def self.age(datetime)
    return Float::INFINITY if datetime.nil?
    ::Time.now - datetime
  end

  def self.older_seconds(datetime, seconds)
    datetime.nil? || datetime.older_than(seconds)
  end

  def self.older_days(datetime, days)
    older_seconds datetime, days.days_in_seconds
  end

  def self.older_hours(datetime, hours)
    older_seconds datetime, hours.hours_in_seconds
  end
end

class Integer
  def days_in_seconds
    TimeHelper.days_to_seconds(self)
  end

  def hours_in_seconds
    TimeHelper.hours_to_seconds(self)
  end
end

module ActiveSupport
  class TimeWithZone
    def older_than(seconds)
      ::Time.now - self > seconds
    end
  end
end

