class Stage < ActiveRecord::Base
  belongs_to :venue

  def to_s
    title
  end
end
