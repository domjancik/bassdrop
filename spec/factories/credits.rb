FactoryGirl.define do
  factory :credit do
    title "Edited by"

    release do
      Release.all.take || FactoryGirl.create(:release)
    end

    artist do
      Artist.all.take || FactoryGirl.create(:artist)
    end

    list_order 1
  end

end
