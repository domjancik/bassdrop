class Image < ActiveRecord::Base
  include Imageable

  validates :title, presence: true
  validates_format_of :title, with: /\A[a-z0-9_-]*\z/, message: "Only lowercase letters, numbers, underscores and hyphens (-) allowed"
end
