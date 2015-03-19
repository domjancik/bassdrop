class Country < ActiveRecord::Base
  has_many :cities

  def to_s
    title
  end
end
