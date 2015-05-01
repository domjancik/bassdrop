class Credit < ActiveRecord::Base
  default_scope { order('credits.list_order asc') }

  belongs_to :release
  belongs_to :artist

  validates :release, presence: true
  validates :artist, presence: true
end
