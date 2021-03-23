# vaccine-spotter

checks [COVID-19 Vaccine Spotter](https://www.vaccinespotter.org) for COVID-19 vaccine every 2 seconds

beeps a bunch when it finds one

## prerequisites

you need to have ruby

 - [mac instructions](https://stackify.com/install-ruby-on-your-mac-everything-you-need-to-get-going/)
 - [windows instructions](https://stackify.com/install-ruby-on-windows-everything-you-need-to-get-going/)

you need to have bundler; run this in your command line

```
gem install bundler
```

## instructions

1. clone this repo or [download as a zip file](https://github.com/getaaron/vaccine-spotter/archive/refs/heads/main.zip)
2. `bundle`
3. open `vaccine.rb` in any text editor
4. edit `state` to your state's 2-letter code like `CA`, `IL`, `NY`, `FL`, etc.
5. edit `closest_zip` to zip code where you live
6. edit `zips_i_want` to an array of zips; you'll be alerted if there's a vaccine in any of them
7. run `bundle exec ruby vaccine.rb`
8. make sure your volume is up so you can hear the beeps
