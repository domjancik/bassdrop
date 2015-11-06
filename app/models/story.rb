class Story < ActiveRecord::Base
  include Avatarable
  include DescriptionLocalizable
  include TitleLocalizable

  PEREX_REGEXP = /^.*?\r?\n\r?\n/m

  belongs_to :release
  belongs_to :artist
  belongs_to :event
  belongs_to :playlist
  belongs_to :author, class_name: 'Artist'

  scope :published, -> { where(published: true).order('published_at desc') }
  scope :hidden, -> { where(published: false) }
  scope :ordered, -> { order('published_at desc') }

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

  def image_missing_url(style)
    return event.cover_url("square_#{style.to_s}".to_sym) unless event.blank?
    return release.image_url(style) unless release.blank?
    return artist.image_url(style) unless artist.blank?

    'default_image.jpg'
  end

  def self.for_locale(locale)
    column = description_column(locale)
    all.where("#{column} IS NOT NULL AND CHAR_LENGTH(#{column}) > 0")
  end

  def self.description_column(locale)
    return 'description' if locale.eql? :en
    "description_#{locale.to_s}"
  end
end
