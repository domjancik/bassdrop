module SocialHelper
  SOCIAL_LINKS = [
    { name: 'facebook', url: 'http://facebook.com' },
    { name: 'soundcloud', url: 'http://soundcloud.com' },
    { name: 'youtube', url: 'http://' },
    { name: 'instagram', url: 'http://' },
  ]

  def social_links
    SocialHelper::SOCIAL_LINKS
  end
end