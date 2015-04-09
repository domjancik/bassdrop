class Story < ActiveRecord::Base
  PEREX_REGEXP = /^.*?\r?\n\r?\n/m

  belongs_to :release
  belongs_to :artist
  belongs_to :event
  belongs_to :playlist
  belongs_to :author, class_name: 'Artist'

  scope :published, -> { where(published: true).order('published_at desc') }
  scope :hidden, -> { where(published: false) }

  validates :author, presence: true
  validates :published_at, presence: true, if: 'published == true'

  def perex
    match = PEREX_REGEXP.match(description)
    text = match.nil? ? description : match.to_s
    text.truncate_words 30
  end

  def next
    Story.published.where('published_at > ?', published_at).last
  end

  def prev
    Story.published.where('published_at < ?', published_at).first
  end

  def image_url
    return event.cover_url(:square_medium) unless event.blank?
    return release.image_url(:medium) unless release.blank?
    return artist.image_url(:medium) unless artist.blank?

    'default_image.jpg'
  end
end
