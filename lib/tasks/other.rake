require 'rest_client'

namespace :other do
  desc 'Do a request'
  task :req do
    RestClient.get 'http://bassdrop.herokuapp.com/events/22.json'
  end
end


