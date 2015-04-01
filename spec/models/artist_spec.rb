require 'rails_helper'

RSpec.describe Artist, type: :model do
  before(:each) { @artist = Artist.find_by(title: 'TestArtist') }

  it 'Test artist is created' do
    expect(@artist).to be_truthy
  end

  it 'Test for country city validation' do
    country = Country.find_by_abbreviation 'TC'
    city = City.create(title: 'CorrectCity', country: country)

    other_country = Country.create(title: 'OtherCountry')
    other_city = City.create(title: 'WrongCity', country: other_country)

    @artist.country = country
    @artist.city = nil

    expect(@artist).to be_valid # Valid without a city

    @artist.city = city
    expect(@artist).to be_valid # Valid with correct city

    @artist.city = other_city
    expect(@artist).to_not be_valid # Invalid with a city from another country
  end
end
