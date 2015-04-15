module LinkHelper
  URL_SECOND_LEVEL_REGEX = /(?:https?:\/\/(?:www.)?)?([a-zA-Z0-9]*\.[a-zA-Z]{2,5}).*/

  def url_second_level(url)
    match_result = URL_SECOND_LEVEL_REGEX.match url
    match_result[1]
  end
end