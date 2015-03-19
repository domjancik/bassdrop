class City < ActiveRecord::Base
  belongs_to :country

  def to_s
    title
  end
end
