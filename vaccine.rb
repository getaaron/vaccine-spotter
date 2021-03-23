# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'set'

state = 'CA'

closest_zip = '95118'

zips_i_want = %w[94089 95002 95008 95013 95014 95032 95035 95037 95050 95054
                 95070 95110 95111 95112 95113 95116 95117 95118 95119 95120
                 95121 95122 95123 95124 95125 95126 95127 95128 95129 95130
                 95131 95132 95133 95134 95135 95136 95138 95139 95140 95148]

while true
  sleep(2)
  domain = 'https://www.vaccinespotter.org'
  url = "#{domain}/#{state}/?zip=#{closest_zip}"
  doc = Nokogiri::HTML.parse(URI.parse(url).open)

  location_results = doc.css('div.location-result')

  result_zips = Set.new

  location_results.each do |lr|
    address = lr.css('h5.col-sm').text
    fields = address.split("\n").map(&:strip).reject!(&:empty?)
    zip_code = fields.last
    result_zips.add(zip_code) if zip_code.to_i.to_s.length == 5
  end

  break unless (zips_i_want.to_set & result_zips).empty?

  puts "\n[#{Time.now.strftime('%H:%M:%S')}] nothing found; closest are #{result_zips.to_a.join(', ')}"
end

matches = zips_i_want.to_set & result_zips

puts "\n\n\nfound vaccines in #{matches.to_a.join(', ')} at #{url}"

20.times do
  print "\a"
  sleep(1)
end
