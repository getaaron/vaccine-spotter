# frozen_string_literal: true

require 'httparty'
require 'json'
require 'os'

# Set these variables
state = 'CA'
zips = %w[94022 94024 94040 94043 94085 94086 94087 94089 94301 94303 94304 94305 94306 95008 95014 95020 95030 95032 95033 95035 95037 95050 95051 95054 95070 95110 95111 95112 95116 95118 95119 95120 95121 95123 95124 95125 95126 95127 95128 95129 95131 95132 95133 95135 95136 95138 95148]
# zip codes of your county or where you're willing to drive to an appointment

# create the 'api' URL based on the user's state
vs_url = 'https://www.vaccinespotter.org/api/v0/states/' + state + '.json'

while true
  # grab latest JSON as array of hashes
  features = JSON.parse(HTTParty.get(vs_url).body)['features']

  # find matches to county_zips AND appointments_available: true -- remove && properties['provider_brand_id'] == 40 if you want other providers than Rite Aid
  matches = features.select { |feature|
    properties = feature['properties']
    zips.include?(properties['postal_code']) && properties['appointments_available'] == true
  }
  # if there are any matches, show the pertinent details
  if matches.count > 0
    matches.each { |match|
      properties = match['properties']
      puts "\n[#{Time.now.strftime('%H:%M:%S')}] Match found!\a"
      puts properties['name']
      puts properties['address']
      puts properties['city'] + " " + properties['state'] + " " + properties['postal_code'] + "\n"
      puts properties['url']
    }
    # if user is on macOS say command to alert the user!
    if OS.mac?
      system("say 'beep! beep! beep! appointment found'")
    else
    # other platforms just get the built-in beep
      20.times do
          print "\a"
      end
    end
    break
  else
    puts "\n[#{Time.now.strftime('%H:%M:%S')}] No appointments found."
  end
  # set how long between checks. vaccinespotter only updates every 60 seconds
  sleep(1)
end
