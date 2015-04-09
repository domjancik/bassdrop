module SocialHelper
  SOCIAL_LINKS = [
    { name: 'facebook', url: 'https://www.facebook.com/bassdropcz' },
    { name: 'soundcloud', url: 'https://www.soundcloud.com/bass-drop-records' },
    { name: 'youtube', url: 'https://www.youtube.com/bassdropcz' },
    { name: 'instagram', url: 'https://instagram.com/bassdropcz/' },
  ]

  SOCIAL_LINKS_RECORDS = [
    { name: 'facebook', url: 'https://www.facebook.com/bassdroprecords' },
    { name: 'soundcloud', url: 'https://www.soundcloud.com/bass-drop-records' },
    { name: 'youtube', url: 'https://www.youtube.com/user/bassdroprecs' },
  ]

  def page_social_links
    SOCIAL_LINKS
  end

  def records_social_links
    SOCIAL_LINKS_RECORDS
  end
end