# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file .env file.

# Countries
countries = [
    ['AC', 'Ascension Island'],
    ['AD', 'Andorra'],
    ['AE', 'United Arab Emirates'],
    ['AF', 'Afghanistan'],
    ['AG', 'Antigua And Barbuda'],
    ['AI', 'Anguilla'],
    ['AL', 'Albania'],
    ['AM', 'Armenia'],
    ['AN', 'Netherlands Antilles'],
    ['AO', 'Angola'],
    ['AQ', 'Antarctica'],
    ['AR', 'Argentina'],
    ['AS', 'American Samoa'],
    ['AT', 'Austria'],
    ['AU', 'Australia'],
    ['AW', 'Aruba'],
    ['AX', 'Åland'],
    ['AZ', 'Azerbaijan'],
    ['BA', 'Bosnia And Herzegovina'],
    ['BB', 'Barbados'],
    ['BE', 'Belgium'],
    ['BD', 'Bangladesh'],
    ['BF', 'Burkina Faso'],
    ['BG', 'Bulgaria'],
    ['BH', 'Bahrain'],
    ['BI', 'Burundi'],
    ['BJ', 'Benin'],
    ['BM', 'Bermuda'],
    ['BN', 'Brunei Darussalam'],
    ['BO', 'Bolivia'],
    ['BR', 'Brazil'],
    ['BS', 'Bahamas'],
    ['BT', 'Bhutan'],
    ['BV', 'Bouvet Island'],
    ['BW', 'Botswana'],
    ['BY', 'Belarus'],
    ['BZ', 'Belize'],
    ['CA', 'Canada'],
    ['CC', 'Cocos (Keeling) Islands'],
    ['CD', 'Congo (Democratic Republic)'],
    ['CF', 'Central African Republic'],
    ['CG', 'Congo (Republic)'],
    ['CH', 'Switzerland'],
    ['CI', 'Cote D’Ivoire'],
    ['CK', 'Cook Islands'],
    ['CL', 'Chile'],
    ['CM', 'Cameroon'],
    ['CN', 'People’s Republic of China'],
    ['CO', 'Colombia'],
    ['CR', 'Costa Rica'],
    ['CU', 'Cuba'],
    ['CV', 'Cape Verde'],
    ['CX', 'Christmas Island'],
    ['CY', 'Cyprus'],
    ['CZ', 'Czech Republic'],
    ['DE', 'Germany'],
    ['DJ', 'Djibouti'],
    ['DK', 'Denmark'],
    ['DM', 'Dominica'],
    ['DO', 'Dominican Republic'],
    ['DZ', 'Algeria'],
    ['EC', 'Ecuador'],
    ['EE', 'Estonia'],
    ['EG', 'Egypt'],
    ['ER', 'Eritrea'],
    ['ES', 'Spain'],
    ['ET', 'Ethiopia'],
    ['EU', 'European Union'],
    ['FI', 'Finland'],
    ['FJ', 'Fiji'],
    ['FK', 'Falkland Islands (Malvinas)'],
    ['FM', 'Micronesia, Federated States Of'],
    ['FO', 'Faroe Islands'],
    ['FR', 'France'],
    ['GA', 'Gabon'],
    #['GB', 'United Kingdom'],
    ['GD', 'Grenada'],
    ['GE', 'Georgia'],
    ['GF', 'French Guiana'],
    ['GG', 'Guernsey'],
    ['GH', 'Ghana'],
    ['GI', 'Gibraltar'],
    ['GL', 'Greenland'],
    ['GM', 'Gambia'],
    ['GN', 'Guinea'],
    ['GP', 'Guadeloupe'],
    ['GQ', 'Equatorial Guinea'],
    ['GR', 'Greece'],
    ['GS', 'South Georgia And The South Sandwich Islands'],
    ['GT', 'Guatemala'],
    ['GU', 'Guam'],
    ['GW', 'Guinea-Bissau'],
    ['GY', 'Guyana'],
    ['HK', 'Hong Kong'],
    ['HM', 'Heard And Mc Donald Islands'],
    ['HN', 'Honduras'],
    ['HR', 'Croatia'],
    ['HT', 'Haiti'],
    ['HU', 'Hungary'],
    ['ID', 'Indonesia'],
    ['IE', 'Ireland'],
    ['IL', 'Israel'],
    ['IM', 'Isle of Man'],
    ['IN', 'India'],
    ['IO', 'British Indian Ocean Territory'],
    ['IQ', 'Iraq'],
    ['IR', 'Iran (Islamic Republic Of)'],
    ['IS', 'Iceland'],
    ['IT', 'Italy'],
    ['JE', 'Jersey'],
    ['JM', 'Jamaica'],
    ['JO', 'Jordan'],
    ['JP', 'Japan'],
    ['KE', 'Kenya'],
    ['KG', 'Kyrgyzstan'],
    ['KH', 'Cambodia'],
    ['KI', 'Kiribati'],
    ['KM', 'Comoros'],
    ['KN', 'Saint Kitts And Nevis'],
    ['KR', 'Korea, Republic Of'],
    ['KW', 'Kuwait'],
    ['KY', 'Cayman Islands'],
    ['KZ', 'Kazakhstan'],
    ['LA', 'Lao People’s Democratic Republic'],
    ['LB', 'Lebanon'],
    ['LC', 'Saint Lucia'],
    ['LI', 'Liechtenstein'],
    ['LK', 'Sri Lanka'],
    ['LR', 'Liberia'],
    ['LS', 'Lesotho'],
    ['LT', 'Lithuania'],
    ['LU', 'Luxembourg'],
    ['LV', 'Latvia'],
    ['LY', 'Libyan Arab Jamahiriya'],
    ['MA', 'Morocco'],
    ['MC', 'Monaco'],
    ['MD', 'Moldova, Republic Of'],
    ['ME', 'Montenegro'],
    ['MG', 'Madagascar'],
    ['MH', 'Marshall Islands'],
    ['MK', 'Macedonia, The Former Yugoslav Republic Of'],
    ['ML', 'Mali'],
    ['MM', 'Myanmar'],
    ['MN', 'Mongolia'],
    ['MO', 'Macau'],
    ['MP', 'Northern Mariana Islands'],
    ['MQ', 'Martinique'],
    ['MR', 'Mauritania'],
    ['MS', 'Montserrat'],
    ['MT', 'Malta'],
    ['MU', 'Mauritius'],
    ['MV', 'Maldives'],
    ['MW', 'Malawi'],
    ['MX', 'Mexico'],
    ['MY', 'Malaysia'],
    ['MZ', 'Mozambique'],
    ['NA', 'Namibia'],
    ['NC', 'New Caledonia'],
    ['NE', 'Niger'],
    ['NF', 'Norfolk Island'],
    ['NG', 'Nigeria'],
    ['NI', 'Nicaragua'],
    ['NL', 'Netherlands'],
    ['NO', 'Norway'],
    ['NP', 'Nepal'],
    ['NR', 'Nauru'],
    ['NU', 'Niue'],
    ['NZ', 'New Zealand'],
    ['OM', 'Oman'],
    ['PA', 'Panama'],
    ['PE', 'Peru'],
    ['PF', 'French Polynesia'],
    ['PG', 'Papua New Guinea'],
    ['PH', 'Philippines, Republic of the'],
    ['PK', 'Pakistan'],
    ['PL', 'Poland'],
    ['PM', 'St. Pierre And Miquelon'],
    ['PN', 'Pitcairn'],
    ['PR', 'Puerto Rico'],
    ['PS', 'Palestine'],
    ['PT', 'Portugal'],
    ['PW', 'Palau'],
    ['PY', 'Paraguay'],
    ['QA', 'Qatar'],
    ['RE', 'Reunion'],
    ['RO', 'Romania'],
    ['RS', 'Serbia'],
    ['RU', 'Russian Federation'],
    ['RW', 'Rwanda'],
    ['SA', 'Saudi Arabia'],
    #['UK', 'Scotland'],
    ['SB', 'Solomon Islands'],
    ['SC', 'Seychelles'],
    ['SD', 'Sudan'],
    ['SE', 'Sweden'],
    ['SG', 'Singapore'],
    ['SH', 'St. Helena'],
    ['SI', 'Slovenia'],
    ['SJ', 'Svalbard And Jan Mayen Islands'],
    ['SK', 'Slovakia'],
    ['SL', 'Sierra Leone'],
    ['SM', 'San Marino'],
    ['SN', 'Senegal'],
    ['SO', 'Somalia'],
    ['SR', 'Suriname'],
    ['ST', 'Sao Tome And Principe'],
    ['SU', 'Soviet Union'],
    ['SV', 'El Salvador'],
    ['SY', 'Syrian Arab Republic'],
    ['SZ', 'Swaziland'],
    ['TC', 'Turks And Caicos Islands'],
    ['TD', 'Chad'],
    ['TF', 'French Southern Territories'],
    ['TG', 'Togo'],
    ['TH', 'Thailand'],
    ['TJ', 'Tajikistan'],
    ['TK', 'Tokelau'],
    ['TI', 'East Timor (new code)'],
    ['TM', 'Turkmenistan'],
    ['TN', 'Tunisia'],
    ['TO', 'Tonga'],
    ['TP', 'East Timor (old code)'],
    ['TR', 'Turkey'],
    ['TT', 'Trinidad And Tobago'],
    ['TV', 'Tuvalu'],
    ['TW', 'Taiwan'],
    ['TZ', 'Tanzania, United Republic Of'],
    ['UA', 'Ukraine'],
    ['UG', 'Uganda'],
    ['UK', 'United Kingdom'],
    ['UM', 'United States Minor Outlying Islands'],
    ['US', 'United States'],
    ['UY', 'Uruguay'],
    ['UZ', 'Uzbekistan'],
    ['VA', 'Vatican City State (Holy See)'],
    ['VC', 'Saint Vincent And The Grenadines'],
    ['VE', 'Venezuela'],
    ['VG', 'Virgin Islands (British)'],
    ['VI', 'Virgin Islands (U.S.)'],
    ['VN', 'Viet Nam'],
    ['VU', 'Vanuatu'],
    ['WF', 'Wallis And Futuna Islands'],
    ['WS', 'Samoa'],
    ['YE', 'Yemen'],
    ['YT', 'Mayotte'],
    ['ZA', 'South Africa'],
    ['ZM', 'Zambia'],
    ['ZW', 'Zimbabwe']
]

countries.each do |country_source|
  country = Country.new
  country.abbreviation = country_source[0]
  country.title = country_source[1]
  country.save
end

puts 'LOADED COUNTRIES'

favorites = %w(UK CZ DE NL IL)
favorites.each do |fav_abbreviation|
  country = Country.find_by_abbreviation fav_abbreviation
  country.favorite = true
  country.save
end

puts 'LOADED COUNTRY FAVORITES'

# CITIES

cities = [
    ['UK', %w(Bristol London Nottingham Bournemouth Guildford)],
    ['CZ', ['Prague', 'Brno', 'Ostrava', 'Aš', 'Slaný', 'Mladá Boleslav', 'Karlovy Vary']],
    ['CH', %w(Basel)],
    ['BE', %w(Waasmunster)],
    ['AT', %w(Vienna)],
    ['DE', %w(Leipzig)]
]

cities.each do |city_list|
  country = Country.find_by_abbreviation city_list[0]
  city_list[1].each do |city_source|
    city = country.cities.create title: city_source
    city.save
  end
end

puts 'LOADED CITIES'

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
    {title: 'Eptic', country: 'UK', city: 'Waasmunster', fb: 'eptic'},
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
]

artists.each do |artist_source|
  country = Country.find_by_abbreviation artist_source[:country]

  artist = Artist.new
  artist.title = artist_source[:title]
  artist.country = country

  if artist_source.has_key? :city
    city = City.find_by_title artist_source[:city]
    artist.city = city
  end

  artist.link_fb = artist_source[:fb] if artist_source.has_key? :fb

  artist.save
end

puts 'LOADED ARTISTS'

