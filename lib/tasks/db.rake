require 'rest_client'
require 'json'

namespace :db do
  desc 'Download BASS DROP events from facebook (Basic data only)'
  task loadevents: :environment do
    page_id = 'bassdropcz'

    params = {access_token: FacebookHelper.access_token}

    response =  RestClient.get "#{FacebookHelper.graph_url}/#{page_id}/events", {params: params}
    json_response = JSON.parse(response)
    add_events json_response

    while json_response['paging'].has_key? 'next'
      next_page = json_response['paging']['next']
      response = RestClient.get next_page
      json_response = JSON.parse(response)
      add_events json_response
    end

    puts 'Loaded FB Events (Basic info), call db:fillevents to load the rest'
  end

  private

  def add_events(json_response)
    json_response['data'].each do |fb_event|
      title = fb_event['name']

      begin
        date_start = fb_event['start_time']
        link_fb = fb_event['id']
        event = Event.new({title: title, date_start: date_start, link_fb: link_fb})
        event.date_end = fb_event['end_time'] if fb_event.has_key? 'end_time'
        event.save
        puts 'Loaded ' + event
      rescue ActiveRecord::RecordNotUnique
        puts 'Already in DB: ' + title
      end
    end
  end

  desc 'Download additional data for events from facebook'
  task fillevents: :environment do
    Event.all.each { |event| event.update_from_fb }
  end

  desc 'Load base artists to the DB'
  task loadartists: :environment do
    # ARTISTS
    artists = [
        # Core
        {title: 'MagNet', country: 'CZ', city: 'Prague', fb: 'MagNetSounds'},
        {title: 'Low Tact', country: 'CZ', city: 'Prague', fb: 'LowTact'},
        {title: 'Hlava', country: 'CZ', city: 'Prague', fb: 'DjHlavaCZ'},
        {title: 'Ollie Torr', country: 'CZ', city: 'Prague', fb: 'OllieTorrMusic'},
        {title: 'Novinski', country: 'CZ', city: 'Prague'},
        {title: 'Furious Freaks', country: 'CZ', city: 'Prague', fb: 'FuriousFreaks'},
        {title: 'No Cure', country: 'CZ', city: 'Prague', fb: 'NoCureOfficial'},
        {title: 'S-BisH', country: 'FR', fb: 'SBisHfr'},
        {title: 'Tezet', country: 'CZ', city: 'Mladá Boleslav', fb: 'tezetmusic'},
        {title: 'Woostep', country: 'CZ', city: 'Prague', fb: 'woostepinfo'},
        {title: 'Target1', country: 'CZ', city: 'Ostrava', fb: 'targetone'},
        {title: 'Meph', country: 'CZ', city: 'Ostrava', fb: 'mephofficial'},
        {title: 'Sufuski', country: 'CZ', city: 'Prague'},
        {title: 'Yendys', country: 'CZ', city: 'Slaný'},

        # Live projects
        {title: 'Acid Lobster', country: 'CZ', city: 'Prague'},
        {title: 'Golden Cat', country: 'CZ', city: 'Prague', fb: 'goldencatcz'},

        # External
        {title: 'Fatty M', country: 'CZ', city: 'Prague', fb: 'milan.fattym'},
        {title: 'Blofeld', country: 'CZ', city: 'Prague', fb: '135831453183518'},
        {title: 'AzAwAkk', country: 'CZ', city: 'Prague', fb: 'Azawakk'},
        {title: 'Gory Ruffian', country: 'CZ', city: 'Karlovy Vary', fb: 'goryruffian'},

        # Events
        {title: 'Eptic', country: 'UK', fb: 'eptic'},
        {title: 'Shiverz', country: 'UK', city: 'London', fb: 'ShiverzDubstepOfficial'},
        {title: 'Cookie Monsta', country: 'UK', city: 'Nottingham', fb: 'Cookie-Monsta-Official'},
        {title: 'Luke Hassan', country: 'UK', city: 'Bristol', fb: 'lukehassanmusic'},
        {title: 'Young D', country: 'UK', city: 'London', fb: 'DJ-Young-D-Selecta-Youngz'},
        {title: 'Efflex', country: 'UK', city: 'London', fb: 'EfflexUK'},
        {title: 'Skelecta', country: 'UK', city: 'London', fb: 'SkelectaUK'},

        # WINTER ARENA 2015
        {title: 'Zomboy', country: 'UK', city: 'Guildford', fb: 'ZomboyOfficial'},
        {title: 'Foreign Beggars', country: 'UK', city: 'London', fb: 'foreignbeggars'},
        {title: 'TC', country: 'UK', city: 'Bristol', fb: 'tc.bristol'},
        {title: 'Loadstar', country: 'UK', city: 'Bristol', fb: 'Loadstarmusic'},
        {title: 'Neonlight', country: 'DE', city: 'Leipzig', fb: 'neonlightbassmusic'},
        {title: 'Skyline', country: 'CZ', city: 'Prague', fb: 'SKYLINE.PRAGUE'},
        {title: 'Loo & Placido', country: 'FR', fb: 'Loo.Placido'},
        {title: 'Suki', country: 'CZ', city: 'Prague', fb: 'deejay.suki'},
        {title: 'Pixie', country: 'CZ', city: 'Prague', fb: '380138722102718'},
        {title: 'Bifidus Aktif', country: 'CZ', city: 'Prague', fb: 'bif.aktif'},

        {title: 'Emperor', country: 'UK', fb: 'EmperorDNB'},
        {title: 'QBIG & Zenith B', country: 'CH', city: 'Basel', fb: 'QbigZenithB'},
        {title: 'London Nebel', country: 'DE', fb: 'londonnebel'},
        {title: 'Kygo', country: 'NO', fb: 'kygoofficial'},
        {title: 'Document One', country: 'UK', fb: 'DocumentOne'},
        {title: 'Trampa', country: 'UK', fb: 'trampadubstep'},
        {title: 'Axel Boy', country: 'UK', fb: 'AxelBoyUK'},
        {title: 'Datsik', country: 'CA', fb: 'djdatsik'},
        {title: 'Le Lion', country: 'NL', fb: 'leliondub'},
        {title: 'Hybris', country: 'US', fb: 'hybrisdnb'},
        {title: 'The Greys', country: 'UK', fb: 'thegreysuk'},
        {title: '50 Carrot', country: 'UK', fb: '50CarrotDubstep'},

        {title: 'Teddy Killerz', country: 'UA', fb: 'teddykillerz1'},
        {title: 'Vladimir 518', country: 'CZ', city: 'Prague', fb: 'Vladimir518Praha'},
        {title: 'LA4', country: 'CZ', fb: 'lavor'},
        {title: 'Mike Trafik', country: 'CZ', fb: 'MIKETRAFIK'},
        {title: 'Hugo Toxxx', country: 'CZ', fb: 'hugo.fanpage'},
        {title: 'Philip TBC', country: 'CZ', fb: '55972720770'},
        {title: 'Rido', country: 'CZ', city: 'Prague', fb: 'ridocz'},
        {title: 'A-Cray', country: 'CZ', city: 'Slaný', fb: 'ACrayCZ'},
        {title: 'Hemoglobin', country: 'CZ', city: 'Slaný', fb: '167766016593070'},
        {title: 'Hanzall', country: 'CZ', city: 'Aš', fb: 'djhanzall'},

        {title: 'Kahlil', country: 'UK', fb: 'Y.Dot.K'},
        {title: 'Allmostt', country: 'UK', fb: 'martinallmostt'},
        {title: 'Tuco', country: 'UK', fb: 'Tucodj'},
        {title: 'IM Cyber', country: 'CZ', fb: 'imcyberdj'},
        {title: 'Anakin', country: 'CZ'},
        {title: 'Lost', country: 'UK', fb: 'losthench'},
        {title: 'Genetix', country: 'UK', city: 'Bournemouth', fb: 'GenetixDubstep'},

        {title: 'Dubschoock', country: 'SK'},
        {title: 'Simon Ekhan', country: 'SK'},
        {title: 'Peter Pan Complex', country: 'CZ'},
        {title: 'Beats.PM', country: 'CZ'},
        {title: 'Ugly', country: 'CZ', city: 'Prague'},

        {title: 'Roksonix', country: 'UK', fb: 'roksonix'},
        {title: 'Gh0sh', country: 'UK', fb: 'Gh0sh'},
        {title: 'Villain', country: 'UK', fb: 'villaindub'},
        {title: 'Emphasis', country: 'AT', fb: '516698048369462'},
        {title: 'Phlage', country: 'AT', city: 'Vienna', fb: 'Phlage'},

        # WINTER ARENA 2014
        {title: 'A.M.C', country: 'UK', fb: 'DJAMC'},
        {title: 'Mefjus', country: 'AT', city: 'Linz', fb: 'mefjus'},
        {title: 'Prago Union', country: 'CZ', city: 'Prague', fb: 'pragounion'},
        {title: 'Manene', country: 'CZ', city: 'Prague', fb: 'ManeneOfficial'},
        {title: 'Twisted Minds', country: 'CZ', city: 'Prague', fb: 'TwistedMindscz'},
        {title: 'Pe:Te', country: 'CZ', city: 'Prague', fb: 'petecz'},

        {title: 'Vermin', country: 'UK', city: 'Wokingham', fb: 'Verminmusic'},
        {title: 'Bio', country: 'CZ', city: 'Ostrava', fb: 'biooo3'},

        {title: 'Martz', country: 'IL', fb: '193956883989406'},

        {title: 'LU2', country: 'CZ', city: 'Prague', fb: 'DJLU2Official'},

        # REZONATOR
        {title: 'BadKlaat', country: 'UK', city: 'Gloucester', fb: 'badklaat'},
        {title: 'Cooh / Balkansky', country: 'BG', city: 'Troyan', fb: 'abcd.ivanshopov'},
        {title: 'Smack', country: 'CZ', city: 'Prague', fb: 'smackofficial'},

        {title: 'QO', country: 'CZ', city: 'Bušperk', fb: 'qosobu'},
        {title: 'MuK', country: 'UK', city: 'Birmingham', fb: 'Mukmusik'},

        {title: 'Dirty Little Toaster', country: 'CZ', city: 'Prague', fb: 'Dirty.little.toaster.dubstep'},

        {title: 'Mr. Boogie', country: 'DE', city: 'Potsdam', fb: 'MrBoogieDubstep'},
        {title: 'Skælp', country: 'BE', city: 'Ghent', fb: '155748314470514'},
        {title: 'Wonkap', country: 'BE', fb: 'WonkapOfficial'},
        {title: 'Sponge Bandits', country: 'UK', city: 'Barrow in Furness', fb: 'Spongebandits'},
        {title: 'Droid', country: 'UK', city: 'Ashford', fb: 'droiddubstep'},
        {title: 'Hassassin', country: 'UK', city: 'Birmingham', fb: 'hassassinuk'},
    ]

    artists.each do |artist_source|
      begin
        country = Country.find_by_abbreviation artist_source[:country]

        artist = Artist.new
        artist.title = artist_source[:title]
        artist.country = country

        if artist_source.has_key? :city
          city_title = artist_source[:city]
          city = City.find_by_title city_title
          if city.nil?
            city = City.create(title: city_title, country: country)
            city.save
          end
          artist.city = city
        end

        artist.link_fb = artist_source[:fb] if artist_source.has_key? :fb

        artist.save
        puts 'Artist loaded - ' + artist_source[:title]
      rescue ActiveRecord::RecordNotUnique
        puts 'Artist already loaded - ' + artist_source[:title]
      end
    end

    puts 'LOADED ARTISTS'
  end
end
