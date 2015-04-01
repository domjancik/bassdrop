FactoryGirl.define do
  factory :artist do
    title "TestArtist"
    city nil

    country do
      Country.find_by(abbreviation: 'TC') || FactoryGirl.create(:country)
    end
  end

end
