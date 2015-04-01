FactoryGirl.define do
  factory :performance do
    stage nil
    date_start "2015-03-19 16:37:02"
    date_end "2015-03-19 16:37:02"

    event do
      Event.find_by_title('TestEvent') || FactoryGirl.create(:event)
    end

    artist do
      Artist.find_by_title('TestArtist') || FactoryGirl.create(:artist)
    end
  end

end
