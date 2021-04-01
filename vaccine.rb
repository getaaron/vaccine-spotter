# frozen_string_literal: true

require 'httparty'
require 'json'
require 'os'
require 'optparse'

def main
  options = {
    poll_rate: 1,
    state: 'IL',
    zip_codes: %w[60601 60602 60603 60604 60612 60606 60607 60647 60622 60667 60610 60611 60654 60614 60657],
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

  poll(options)
end

def poll(options)
  vs_url = "https://www.vaccinespotter.org/api/v0/states/#{options[:state]}.json"
  puts "Using endpoint: #{vs_url}" if options[:verbose]

  loop do
    time_prefix = "\n[#{Time.now.strftime('%H:%M:%S')}]"

    features = JSON.parse(HTTParty.get(vs_url).body)['features']

    matches = features.select do |feature|
      properties = feature['properties']
      next options[:zip_codes].include?(properties['postal_code']) &&
        properties['appointments_available'] == true
    end

    if matches.count.positive?
      matches.each do |match|
        properties = match['properties']
        puts "#{time_prefix} Match found!\a"
        print_match(properties)
      end

      show_alert
      break
    else
      puts "#{time_prefix} No appointments found."
    end
    sleep(options[:poll_rate])
  end
end

def print_match(properties)
  puts properties['name']
  puts properties['address']
  puts "#{properties['city']}, #{properties['state']}, #{properties['postal_code']}\n"
  puts properties['url']
end

def show_alert
  if OS.mac?
    system("say 'beep! beep! beep! appointment found'")
  else
    20.times { print "\a" }
  end
end

main
