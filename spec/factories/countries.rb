FactoryGirl.define do
  factory :country do
    title =  "TestCountry"
    abbreviation = "TC"

    initialize_with { Country.find_or_create_by(abbreviation: abbreviation, title: title)}
  end

end
