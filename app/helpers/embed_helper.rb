module EmbedHelper
  YOUTUBE_REGEX = /(?:https?:\/\/(?:www.)?)?(?:youtube.com|youtu.be)\/(?:watch\?v=)?([a-zA-Z0-9-_]*).*/

  def embed(medium)
    service = which_service medium.url

    return embed_universal medium if service == :unknown

    service_name = service.to_s
    id = self.send('id_' + service_name, medium.url)
    self.send('embed_' + service_name, id)
  end

  private
  def which_service(url)
    return :youtube unless (YOUTUBE_REGEX.match url).nil?
    :unknown
  end

  # Wrap given content in a div tag with class videoWrapper,
  # which is styled to keep 16:9 aspect ratio of sub iframes
  def wrap_video(content)
    content_tag(:div, content, class: 'videoWrapper')
  end

  # YOUTUBE
  def id_youtube(url)
    (YOUTUBE_REGEX.match url)[1]
  end

  def embed_youtube(id)
    wrap_video raw("<iframe width='100%' height='450' src='https://www.youtube.com/embed/#{id}' frameborder='0' allowfullscreen></iframe>")
  end

  # (N)OEMBED FALLBACK

  def embed_universal(medium)
    params = { nowrap: 'on', maxheight: '200' }
    wrap_video (raw (medium.oembed_info params)['html'])
  end
end