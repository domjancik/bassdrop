FactoryGirl.define do
  factory :release_medium do
    release nil
    release do
      Release.all.take || FactoryGirl.create(:release)
    end

    media_item do
      MediaItem.all.take || FactoryGirl.create(:media_item)
    end

    list_order 1
  end

end
