require 'rest_client'
require 'json'

namespace :db do
  namespace :events do
    desc 'Download BASS DROP events from facebook (Basic data only)'
    task load: :environment do
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
    task fill: :environment do
      Event.where(automatic_updates: true).each { |event| event.update_from_fb }
    end

    desc 'Update stats for upcoming events'
    task :update_stats, [ :scope ] => :environment do |t, args|
      args.with_defaults(scope: 'upcoming')
      events = Event.send args[:scope]
      events.each { |event| event.update_stats }
    end

    desc 'Publish given scope'
    task :publish, [ :scope ] => :environment do |t, args|
      events = Event.send args[:scope]
      events.each { |event| event.publish! }
    end
  end


  namespace :artists do
    desc 'Load base artists to the DB'
    task load: :environment do
      # ARTISTS
      artists = [
          # Core
          {title: 'MagNet', country: 'CZ', city: 'Prague', fb: 'MagNetSounds', sc: 'magnetcz', tw: 'magnetcz', role: 'bassdrop'},
          {title: 'Low Tact', country: 'CZ', city: 'Prague', fb: 'LowTact', sc: 'lowtact', role: 'bassdrop'},
          {title: 'Hlava', country: 'CZ', city: 'Prague', fb: 'DjHlavaCZ', role: 'bassdrop'},
          {title: 'Ollie Torr', country: 'CZ', city: 'Prague', fb: 'OllieTorrMusic', role: 'bassdrop'},
          {title: 'Novinski', country: 'CZ', city: 'Prague', role: 'bassdrop', fb: 'tomas.novotny.739'},
          {title: 'Furious Freaks', country: 'CZ', city: 'Prague', fb: 'FuriousFreaks', role: 'bassdrop'},
          {title: 'No Cure', country: 'CZ', city: 'Prague', fb: 'NoCureOfficial', role: 'bassdrop'},
          {title: 'S-BisH', country: 'FR', fb: 'SBisHfr', role: 'bassdrop'},
          {title: 'Tezet', country: 'CZ', city: 'Mladá Boleslav', fb: 'tezetmusic', role: 'bassdrop'},
          {title: 'Woostep', country: 'CZ', city: 'Prague', fb: 'woostepinfo', role: 'bassdrop'},
          {title: 'Target1', country: 'CZ', city: 'Ostrava', fb: 'targetone', role: 'bassdrop'},
          {title: 'Meph', country: 'CZ', city: 'Nový Jičín', fb: 'mephofficial', sc: 'mephofficial', role: 'bassdrop'},

          {title: 'Marek Šilpoch', country: 'CZ', city: 'Prague', fb: 'mark.silpoch', role: 'creator'},
          {title: 'Ondřej Jelínek', country: 'CZ', city: 'Prague', fb: 'ondrej.jelinek.9', role: 'creator'},
          {title: 'Hayppa', country: 'CZ', city: 'Prague', fb: 'Hayppa', role: 'creator'},
          {title: 'Tomáš Teglý', country: 'CZ', city: 'Prague', fb: '252554171461710', role: 'creator'},
          {title: 'Jakub Chudý', country: 'CZ', city: 'Prague', fb: 'chudy.jakub', role: 'creator'},
          {title: 'Sláva Pecháček', country: 'CZ', city: 'Prague', fb: 'slava.pechacek', role: 'creator'},
          {title: 'Filip Kettner', country: 'CZ', city: 'Prague', fb: 'kazisvjed', role: 'creator'},
          {title: 'Francis Svěrák', country: 'CZ', city: 'Prague', fb: 'fsxaico', role: 'creator'},
          {title: 'Jan Schwarcz', country: 'CZ', city: 'Prague', fb: 'jan.schwarcz.3', role: 'creator'},
          {title: 'Filip Hodas', country: 'CZ', city: 'Prague', fb: 'hoodass', role: 'creator'},
          {title: 'Bjørn Mong', country: 'NO', fb: 'bjornmong', role: 'creator'},

          {title: 'Sufuski', country: 'CZ', city: 'Prague', fb: 'zdenda.mahdal'},
          {title: 'Yendys', country: 'CZ', city: 'Slaný', fb: 'jan.studeny'},
          {title: 'Touch the Jungle', country: 'CZ', fb: 'touchthejungle'},
          {title: 'Prag:Matics Crew', country: 'CZ', city: 'Prague', fb: 'prg.matics'},

          # Live projects
          {title: 'Acid Lobster', country: 'CZ', city: 'Prague'},
          {title: 'Golden Cat', country: 'CZ', city: 'Prague', fb: 'goldencatcz'},

          # External
          {title: 'Fatty M', country: 'CZ', city: 'Prague', fb: 'milan.fattym'},
          {title: 'Blofeld', country: 'CZ', city: 'Prague', fb: '135831453183518'},
          {title: 'AzAwAkk', country: 'CZ', city: 'Prague', fb: 'Azawakk'},
          {title: 'Gory Ruffian', country: 'CZ', city: 'Karlovy Vary', fb: 'goryruffian'},
          {title: 'Tesy', country: 'CZ', city: 'Kladno', fb: 'TESYcz'},

          # Records
          {title: 'Kutlo', country: 'SK', city: 'Prievidza', fb: 'kutlo.official', sc: 'dubtrax', role: 'records'},
          {title: 'Dubtrax', country: 'CZ', city: 'Olomouc', fb: '339940515051', sc: 'dubtrax', role: 'records'},
          {title: 'Recalibrate', country: 'UK', role: 'records'},
          {title: 'Monk', country: 'UK', fb: '238529199643264', role: 'records'},
          {title: 'L3MMY DUBZ', country: 'UK', fb: 'Liam.Gamer.Laverick.2910', sc: 'l3mmy-dubz', role: 'records'},
          {title: 'Envenom', country: 'UK', fb: 'envenomdnb', sc: 'envenommusic', role: 'records'},

          # Events
          {title: '2TAKT', country: 'CZ', fb: '2TAKTdjs'},
          {title: 'Murte Kostka', country: 'CZ', city: 'Prague', fb: 'MURTE.CZ', yt: 'd2n3b'},
          {title: 'Funspeed', country: 'CZ', city: 'Prague', fb: '120717838089943'},
          {title: 'Hugorieri', country: 'CZ', fb: 'radim.hugorieri', yt: 'channel/UCtXw5FXrNprbkX61jzDP5pg' },
          {title: 'Dr. One', country: 'CZ', fb: 'Majinee' },
          {title: 'The Thrillest', country: 'CZ', city: 'Prague', fb: 'TheThrillestPRG' },

          {title: 'Eptic', country: 'BE', fb: 'eptic', city: 'Waasmunster', role: 'headliner'},
          {title: 'Shiverz', country: 'UK', city: 'London', fb: 'ShiverzDubstepOfficial', role: 'headliner'},
          {title: 'Cookie Monsta', country: 'UK', city: 'Nottingham', fb: '175957405757449', role: 'headliner'},
          {title: 'Luke Hassan', country: 'UK', city: 'Bristol', fb: 'lukehassanmusic', role: 'headliner'},
          {title: 'Young D', country: 'UK', city: 'London', fb: '129693933739932', role: 'headliner'},
          {title: 'Efflex', country: 'UK', city: 'London', fb: 'EfflexUK', role: 'headliner'},
          {title: 'Skelecta', country: 'UK', city: 'London', fb: 'SkelectaUK', role: 'headliner'},

          # WINTER ARENA 2015
          {title: 'Zomboy', country: 'UK', city: 'Guildford', fb: 'ZomboyOfficial', role: 'headliner'},
          {title: 'Foreign Beggars', country: 'UK', city: 'London', fb: 'foreignbeggars', role: 'headliner'},
          {title: 'TC', country: 'UK', city: 'Bristol', fb: 'tc.bristol', role: 'headliner'},
          {title: 'Loadstar', country: 'UK', city: 'Bristol', fb: 'Loadstarmusic', role: 'headliner'},
          {title: 'Neonlight', country: 'DE', city: 'Leipzig', fb: 'neonlightbassmusic', role: 'headliner'},
          {title: 'Skyline', country: 'CZ', city: 'Prague', fb: 'SKYLINE.PRAGUE', role: 'headliner'},
          {title: 'Loo & Placido', country: 'FR', fb: 'Loo.Placido', role: 'headliner'},
          {title: 'Suki', country: 'CZ', city: 'Prague', fb: 'deejay.suki'},
          {title: 'Pixie', country: 'CZ', city: 'Prague', fb: '380138722102718'},
          {title: 'Bifidus Aktif', country: 'CZ', city: 'Prague', fb: 'bif.aktif'},

          {title: 'Emperor', country: 'UK', fb: 'EmperorDNB', role: 'headliner'},
          {title: 'QBIG & Zenith B', country: 'CH', city: 'Basel', fb: 'QbigZenithB', role: 'headliner'},
          {title: 'London Nebel', country: 'DE', fb: 'londonnebel', role: 'headliner'},
          {title: 'Kygo', country: 'NO', fb: 'kygoofficial', role: 'headliner'},
          {title: 'Thomas Jack', country: 'US', fb: 'thomasjackmusic', role: 'headliner'},
          {title: 'Document One', country: 'UK', fb: 'DocumentOne', role: 'headliner'},
          {title: 'Trampa', country: 'UK', fb: 'trampadubstep', role: 'headliner'},
          {title: 'Axel Boy', country: 'UK', fb: 'AxelBoyUK', role: 'headliner'},
          {title: 'Datsik', country: 'CA', fb: 'djdatsik', role: 'supported'},
          {title: 'Le Lion', country: 'NL', fb: 'leliondub', role: 'headliner'},
          {title: 'Bundat', country: 'UK', city: 'London', fb: 'BundatDubs', sc: 'bundat', role: 'headliner'},
          {title: 'Subset', country: 'US', city: 'New York', fb: 'djsubset', sc: 'subsetgetsit', role: 'headliner'},

          {title: 'Hybris', country: 'US', fb: 'hybrisdnb', role: 'headliner'},
          {title: 'L33', country: 'BG', fb: 'L33music', role: 'headliner'},
          {title: 'The Greys', country: 'UK', fb: 'thegreysuk', role: 'headliner'},
          {title: '50 Carrot', country: 'UK', fb: '50CarrotDubstep', role: 'headliner'},

          {title: 'Teddy Killerz', country: 'UA', fb: 'teddykillerz1', role: 'headliner'},
          {title: 'Vladimir 518', country: 'CZ', city: 'Prague', fb: 'Vladimir518Praha', role: 'headliner'},
          {title: 'LA4', country: 'CZ', fb: 'lavor'},
          {title: 'Mike Trafik', country: 'CZ', fb: 'MIKETRAFIK'},
          {title: 'Hugo Toxxx', country: 'CZ', fb: 'hugo.fanpage', role: 'headliner'},
          {title: 'Philip TBC', country: 'CZ', fb: '55972720770'},
          {title: 'Rido', country: 'CZ', city: 'Prague', fb: 'ridocz'},
          {title: 'A-Cray', country: 'CZ', city: 'Slaný', fb: 'ACrayCZ'},
          {title: 'Hemoglobin', country: 'CZ', city: 'Slaný', fb: '167766016593070'},
          {title: 'Hanzall', country: 'CZ', city: 'Aš', fb: 'djhanzall'},

          {title: 'Kahlil', country: 'UK', fb: 'KahlilDubz13', role: 'headliner'},
          {title: 'Allmostt', country: 'UK', fb: 'martinallmostt'},
          {title: 'Tuco', country: 'UK', fb: 'Tucodj'},
          {title: 'IM Cyber', country: 'CZ', fb: 'imcyberdj'},
          {title: 'Anakin', country: 'CZ'},
          {title: 'Lost', country: 'UK', fb: 'losthench', role: 'headliner'},
          {title: 'Fade', country: 'UA', fb: 'Fademusica', role: 'headliner'},
          {title: 'Genetix', country: 'UK', city: 'Bournemouth', fb: 'GenetixDubstep', role: 'headliner'},

          {title: 'Dubschoock', country: 'SK'},
          {title: 'Simon Ekhan', country: 'SK', fb: '283591461699678'},
          {title: 'Peter Pan Complex', country: 'CZ', fb: 'peterpancpx'},
          {title: 'Beats.PM', country: 'CZ', fb: 'thebeatspm'},
          {title: 'Ugly', country: 'CZ', city: 'Prague', fb: 'filip.krasny' },

          {title: 'Roksonix', country: 'UK', fb: 'roksonix', role: 'headliner'},
          {title: 'Villain', country: 'UK', fb: 'villaindub', role: 'headliner'},
          {title: 'Emphasis', country: 'AT', fb: '516698048369462'},
          {title: 'Phlage', country: 'AT', city: 'Vienna', fb: 'Phlage'},

          # WINTER ARENA 2014
          {title: 'A.M.C', country: 'UK', fb: 'DJAMC', role: 'headliner'},
          {title: 'Mefjus', country: 'AT', city: 'Linz', fb: 'mefjus', role: 'headliner'},
          {title: 'Prago Union', country: 'CZ', city: 'Prague', fb: 'pragounion', role: 'headliner'},
          {title: 'Manene', country: 'CZ', city: 'Prague', fb: 'ManeneOfficial'},
          {title: 'Twisted Minds', country: 'CZ', city: 'Prague', fb: 'TwistedMindscz'},
          {title: 'Pe:Te', country: 'CZ', city: 'Prague', fb: 'petecz'},

          {title: 'Vermin', country: 'UK', city: 'Wokingham', fb: 'Verminmusic', role: 'headliner'},
          {title: 'Bio', country: 'CZ', city: 'Ostrava', fb: 'biooo3'},

          {title: 'Martz', country: 'IL', fb: '193956883989406', role: 'headliner'},

          {title: 'LU2', country: 'CZ', city: 'Prague', fb: 'DJLU2Official'},

          # REZONATOR
          {title: 'BadKlaat', country: 'UK', city: 'Gloucester', fb: 'badklaat', role: 'headliner'},
          {title: 'Cooh / Balkansky', country: 'BG', city: 'Troyan', fb: 'abcd.ivanshopov', role: 'headliner'},
          {title: 'Smack', country: 'CZ', city: 'Prague', fb: 'smackofficial', role: 'headliner'},

          {title: 'QO', country: 'CZ', city: 'Bušperk', fb: 'qosobu'},
          {title: 'MuK', country: 'UK', city: 'Birmingham', fb: 'Mukmusik', role: 'headliner'},

          {title: 'Dirty Little Toaster', country: 'CZ', city: 'Prague', fb: 'Dirty.little.toaster.dubstep', role: 'headliner'},

          {title: 'Mr. Boogie', country: 'DE', city: 'Potsdam', fb: 'MrBoogieDubstep', role: 'headliner'},
          {title: 'Skælp', country: 'BE', city: 'Ghent', fb: '155748314470514', role: 'headliner'},
          {title: 'Wonkap', country: 'BE', fb: 'WonkapOfficial', role: 'headliner'},
          {title: 'Sponge Bandits', country: 'UK', city: 'Barrow in Furness', fb: 'Spongebandits', role: 'headliner'},
          {title: 'Droid', country: 'UK', city: 'Ashford', fb: 'droiddubstep', role: 'headliner'},
          {title: 'Hassassin', country: 'UK', city: 'Birmingham', fb: 'hassassinuk', role: 'headliner'},

          # SUPPORTED
          {title: 'I AM LEGION', country: 'UK', city: 'London', fb: 'iamlegionmusic', role: 'supported'},
          {title: 'CYBERPUNKERS', country: 'IT', city: 'Milan', fb: 'CYBERPUNKERSOFFICIAL', role: 'supported'},
          {title: 'BELZEBASS', country: 'IT', city: 'Bergamo', fb: 'belzebassofficial', role: 'supported'},
          {title: 'The Boomzers', country: 'IT', city: 'Pordenone', fb: 'theboomzers', role: 'supported'},
          {title: 'Borgore', country: 'IL', fb: 'Borgore', role: 'supported'},
          {title: 'Dope D.O.D.', country: 'NL', fb: 'dopedoddopedod', role: 'supported'},
          {title: 'Bassnectar', country: 'US', fb: 'Bassnectar', role: 'supported'},
          {title: 'N.O.H.A.', country: 'CZ', fb: 'NohaCircus', role: 'supported'},
      ]

      artists.each do |artist_source|
        begin
          country = Country.find_by_abbreviation artist_source[:country]

          raise "Country #{artist_source[:country]} missing" if country.nil?

          artist_title = artist_source[:title]

          artist = Artist.find_by_title artist_title
          artist = Artist.new if artist.nil?

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
          artist.link_soundcloud = artist_source[:sc] if artist_source.has_key? :sc
          artist.link_youtube = artist_source[:yt] if artist_source.has_key? :yt
          artist.link_twitter = artist_source[:tw] if artist_source.has_key? :tw
          artist.link_instagram = artist_source[:ig] if artist_source.has_key? :ig

          artist.role = artist_source[:role] if artist_source.has_key? :role

          puts 'Artist loaded - ' + artist_title if artist.new_record?
          puts 'Artist updated - ' + artist_title unless artist.new_record?

          artist.save
        rescue ActiveRecord::RecordNotUnique
          puts 'Artist already loaded - ' + artist_source[:title]
        end
      end

      puts 'LOADED ARTISTS'
    end

    task reload_images: :environment do
      Artist.all.each do |artist|
        artist.refresh_image_cache
        artist.force_refresh_image_cache if artist.image_url_cached.nil?

        puts "Couldn't load@event.stages image for #{artist}" if artist.image_url_cached.nil?
      end
    end
  end

  namespace :releases do
    desc 'Load records'
    task load_records: :environment do
      load_file 'db/seeds/records.yml', 'record'
    end

    desc 'Load trailers (video invitations)'
    task load_trailers: :environment do
      load_file 'db/seeds/video_invitations.yml', 'trailer'
    end

    desc 'Load aftermovies'
    task load_aftermovies: :environment do
      load_file 'db/seeds/video_aftermovies.yml', 'aftermovie'
    end

    def load_file(filename, type)
      ActiveRecord::Base.transaction do
        rel_file = YAML.load_file filename
        releases = rel_file['releases']

        releases.each_pair do |code, release_src|
          puts 'Loading ' + code

          release = Release.find_by(rel_code: code)
          release = Release.create(rel_code: code) if release.nil?

          release.release_type = type

          release.title = release_src['title']
          release.description = release_src['description']
          release.release_date = release_src['date']
          release.get_url = release_src['url']

          artists = release_src['artists']
          # raise 'Artists are missing' if artists.nil?
          credits = release_src['credits']
          load_credits release, artists, credits

          tracks = release_src['tracks']
          raise 'Tracks are missing' if tracks.nil?
          load_playlist release, tracks

          release.save
        end
      end
    end

    def load_playlist(release, tracks)
      if release.playlist.blank?
        playlist = Playlist.create_for release
      else
        playlist = release.playlist

        # Check if playlist was changed
        playlist.items.each_with_index do |item, index|
          unless item.medium.url.eql?(tracks[index])
            playlist.items.each { |item| item.destroy }
            break
          end
        end
      end

      if playlist.items.empty?
        tracks.each_with_index do |track_url, index|
          track = Medium.find_by url: track_url
          if track.nil?
            track = Medium.create url: track_url
            track.fill_blanks!
          end
          playlist.items.create(medium: track, list_order: index)
        end
      end
    end
    def load_credits(release, artists, extra_credits)
      # Join artists and extra credits into credits
      credits = []

      unless artists.nil?
        credits = artists.inject(credits) do |arr, artist_title|
          artist = Artist.find_by! title: artist_title
          arr << {artist: artist, title: ''}
        end
      end

      unless extra_credits.nil?
        credits = extra_credits.to_a.inject(credits) do |arr, credit|
          credit_title = credit[0]
          credit_artists = credit[1]

          artist_list = credit_artists.kind_of?(Array) ? credit_artists : [ credit_artists ]

          artist_list.each do |artist_title|
            artist = Artist.find_by! title: artist_title
            credit_hash = {artist: artist, title: credit_title}
            arr << credit_hash
          end

          arr
        end
      end

      unless release.credits.empty?
        # Check if credits were changed
        release.credits.each_with_index do |credit, index|
          same = credit.artist.eql?(credits[index][:artist])
          same &&= credit.title.eql?(credits[index][:title])
          same &&= credit.list_order == index

          unless same
            release.credits.each { |credit| credit.destroy }
            break
          end
        end
      end

      release.save
      release.reload
      if release.credits.empty?
        credits.each_with_index do |credit, index|
          release.credits.create(title: credit[:title], artist: credit[:artist], list_order: index)
        end
      end
    end
  end
end
