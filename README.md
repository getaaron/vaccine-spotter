# vaccine-spotter

Simple script to check [COVID-19 Vaccine Spotter](https://www.vaccinespotter.org) for COVID-19 vaccine appointments every one second and beeps a bunch when it finds one!

## prerequisites

You need to have ruby

 - [macOS instructions](https://stackify.com/install-ruby-on-your-mac-everything-you-need-to-get-going/)
 - [Windows instructions](https://stackify.com/install-ruby-on-windows-everything-you-need-to-get-going/)

after you install ruby, you also need to install bundler; run this in your command line

```
gem install bundler
```

## short instructions (if you're familiar with ruby / command line tools)

1. clone repo
1. `bundle`
1. `bundle exec ruby vaccine.rb --state <state code> --zipcodes <list of zipcodes>` (for example `bundle exec ruby vaccine.rb --state CA --zipcodes 94022,94024`)
1. For all options run `bundle exec ruby vaccine.rb --help`

## longer instructions (if this stuff is alien to you)

1. clone this repo or [download as a .zip file](https://github.com/getaaron/vaccine-spotter/archive/refs/heads/main.zip)
1. open a command line tool (e.g. Terminal.app / iTerm.app on Mac)
1. change to the `vaccine-spotter` directory; for example
      ```bash
      cd ~/Downloads/vaccine-spotter
      ```
   On macOS, if you don't know the exact path, you can just type `cd ` and then drag the folder from Finder into the Terminal window, then press return
1. run `bundle` to install dependencies
1. open `vaccine.rb` in any text editor, like Atom, VSCode, or TextEdit
1. `bundle exec ruby vaccine.rb --state <state code> --zipcodes <list of zipcodes>` (for example `bundle exec ruby vaccine.rb --state CA --zipcodes 94022,94024`)
1. state is the 2 letter abbreviation (examples: `CA`, `NY`, `IL`, etc)
1. zip codes are a list, and you'll be alerted if there's a vaccine in any of them
1. make sure your volume is ALL THE WAY UP so you can hear the beeps even if you're sleeping
