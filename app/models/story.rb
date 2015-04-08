class Story < ActiveRecord::Base
  PEREX_REGEXP = /^.*?\r?\n\r?\n/m

  default_scope { order('published_at desc') }

  belongs_to :release
  belongs_to :artist
  belongs_to :event
  belongs_to :playlist
  belongs_to :author, class_name: 'Artist'

  validates :author, presence: true
  validates :published_at, presence: true, if: 'published == true'

  def perex
    match = PEREX_REGEXP.match(description)
    match.nil? ? description : match.to_s
  end
end