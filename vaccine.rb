# frozen_string_literal: true

require 'httparty'
require 'json'
require 'os'
require 'optparse'

options = {
  poll_rate: 5,
  state: 'CA',
  zip_codes:  %w[94022 94024 94040 94043 94085 94086 94087 94089 94301 94303 94304 94305 94306 95008 95014 95020 95030 95032 95033 95035 95037 95050 95051 95054 95070 95110 95111 95112 95116 95118 95119 95120 95121 95123 95124 95125 95126 95127 95128 95129 95131 95132 95133 95135 95136 95138 95148],
  verbose: false
}

OptionParser.new do |opts|
  opts.banner = 'Usage: bundle exec ruby vaccine.rb [OPTIONS]'

  opts.on('-s', '--state [STATE]', String, 'State abbreviation (ie, IL, CA)') do |state|
    options[:state] = state
  end

  opts.on('-z', '--zipcodes [ZIP_CODES]', Array, 'List of zipcodes (ie, 123,456,124') do |zip_codes|
    options[:zip_codes] = zip_codes
  end

  opts.on('--poll-rate N', Integer, 'Poll rate to vaccinespotter') do |poll_rate|
    options[:poll_rate] = poll_rate
  end

  opts.on_tail('--verbose', 'Extra logging') do
    options[:verbose] = true
  end

  opts.on_tail('-h', '--help', 'Display this message') do
    puts opts
  end
end.parse!

puts options.inspect if options[:verbose]

# create the 'api' URL based on the user's state
vs_url = 'https://www.vaccinespotter.org/api/v0/states/' + options[:state] + '.json'
puts "Using endpoint: #{vs_url}" if options[:verbose]

loop do
  time_prefix = "\n[#{Time.now.strftime('%H:%M:%S')}]"

  # grab latest JSON as array of hashes
  features = JSON.parse(HTTParty.get(vs_url).body)['features']

  # find matches to county_zips AND appointments_available: true -- remove && properties['provider_brand_id'] == 40 if you want other providers than Rite Aid
  matches = features.select do |feature|
    properties = feature['properties']
    options[:zip_codes].include?(properties['postal_code']) && properties['appointments_available'] == true
  end

  # if there are any matches, show the pertinent details
  if matches.count > 0
    matches.each do |match|
      properties = match['properties']
      puts "#{time_prefix} Match found!\a"
      puts properties['name']
      puts properties['address']
      puts properties['city'] + " " + properties['state'] + " " + properties['postal_code'] + "\n"
      puts properties['url']
    end

    # if user is on macOS say command to alert the user!
    if OS.mac?
      system("say 'beep! beep! beep! appointment found'")
    else
    # other platforms just get the built-in beep
      20.times { print "\a" }
    end
    break
  else
    puts "#{time_prefix} No appointments found."
  end
  # set how long between checks. vaccinespotter only updates every 60 seconds
  sleep(options[:poll_rate])
end
