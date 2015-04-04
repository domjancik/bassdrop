RSpec.configure do |config|
  config.around(:each) do |example|
    example.run
  end
end

RSpec.describe FacebookHelper, type: :helper do
  USER_ID = 'MagNetCZ'
  PAGE_ID = 'bassdropcz'

  it 'Loads profile picture for user' do
    image_url = FacebookHelper.fb_profile_picture_url USER_ID
    expect(image_url).to be_truthy
    expect(image_url).to match(/^https:\/\/fbcdn-profile-a.akamaihd.net.*/)
  end

  it 'Loads profile picture for page ' do
    image_url = FacebookHelper.fb_profile_picture_url PAGE_ID
    expect(image_url).to be_truthy
    expect(image_url).to match(/^https:\/\/fbcdn-profile-a.akamaihd.net.*/)
  end
end