FactoryGirl.define do
  factory :release do
    title "TestRelease"
    rel_code "T001"
    get_url "http://www.release.com"
    get_text nil
    release_date "2015-04-02"
    type 1
  end

end
