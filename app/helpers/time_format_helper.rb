module TimeFormatHelper

  # @param [DateTime] date
  def lineup_time(date)
    I18n.l date, format: :lineup_time
  end

  def lineup_from_to(performance)
    return '' if performance.date_start.nil? || performance.date_end.nil?
    lineup_time(performance.date_start) + '-' + lineup_time(performance.date_end)
  end

  def event_date(event)
    unless event.spans_more_days?
      I18n.l event.date_start, format: :event_date
    else
      I18n.l(event.date_start, format: :event_date_from)\
      + I18n.l(event.date_end, format: :event_date_to)
    end
  end

  def event_time(event)
    I18n.l event.date_start, format: :event_time
  end

  def release_date(date)
    format = date.year == Time.now.year ? :release_date : :release_date_full
    l date, format: format
  end
end