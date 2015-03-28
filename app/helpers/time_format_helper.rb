module TimeFormatHelper

  # @param [DateTime] date
  def lineup_time(date)
    date.strftime '%H:%M'
  end

  def lineup_from_to(date_from, date_to)
    lineup_time(date_from) + '-' + lineup_time(date_to)
  end

  def event_date(event)
    if event.date_end.nil?
      I18n.l event.date_start, format: :event_date
    else
      I18n.l(event.date_start, format: :event_date_from)\
      + I18n.l(event.date_end, format: :event_date_to)
    end
  end
end