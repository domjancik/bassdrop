module SocialHelper
  SOCIAL_LINKS = [
    { name: 'facebook', url: 'https://www.facebook.com/bassdropcz' },
    { name: 'soundcloud', url: 'https://www.soundcloud.com/bass-drop-records' },
    { name: 'youtube', url: 'https://www.youtube.com/bassdropcz' },
    { name: 'instagram', url: 'https://instagram.com/bassdropcz/' },
  ]

  def social_links
    SocialHelper::SOCIAL_LINKS
  end
end