class Venue < ActiveRecord::Base
  has_many :events
  has_many :stages
  validates :title, presence: true

  def to_s
    title
  end

  # Load data from the given json
  def load_from_fb_json(json)
    self.title = json['name']
    self.link_fb = json['id']

    # TODO address + city + country
  end

  # Retrieves or creates a venue based on the 'place' fb object
  def self.from_fb_json(json)
    fb_id = json['id']

    venue = Venue.find_by_link_fb fb_id
    return venue unless venue.nil?

    venue = Venue.new
    venue.load_from_fb_json json
    venue.save

    venue
  end
end
