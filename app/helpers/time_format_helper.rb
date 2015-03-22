module TimeFormatHelper

  # @param [DateTime] date
  def lineup_time(date)
    date.strftime '%H:%M'
  end

  def lineup_from_to(date_from, date_to)
    lineup_time(date_from) + '-' + lineup_time(date_to)
  end
end