class ReleaseMedium < ActiveRecord::Base
  default_scope { order('list_order asc') }

  belongs_to :release
  belongs_to :medium
end
