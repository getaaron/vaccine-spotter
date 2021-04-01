# vaccine-spotter

- Checks [COVID-19 Vaccine Spotter](https://www.vaccinespotter.org) for COVID-19 vaccine appointments
- Beeps a bunch when it finds one

## prerequisites

You need to have Ruby:

 - [macOS instructions](https://stackify.com/install-ruby-on-your-mac-everything-you-need-to-get-going/)
 - [Windows instructions](https://stackify.com/install-ruby-on-windows-everything-you-need-to-get-going/)

After you install Ruby, you also need to install bundler. To install, run this on your command line:

```
gem install bundler
```

## Short instructions (if you're familiar with Ruby / command line tools)

1. Clone this repo
1. `bundle`
1. `bundle exec ruby vaccine.rb --state <state code> --zipcodes <list of zipcodes>` (for example `bundle exec ruby vaccine.rb --state CA --zipcodes 94022,94024`)
1. For all options run `bundle exec ruby vaccine.rb --help`

## Longer instructions (if this stuff is alien to you)

1. Clone this repo or [download as a .zip file](https://github.com/getaaron/vaccine-spotter/archive/refs/heads/main.zip)
1. Open a command line tool (e.g. Terminal.app / iTerm.app on Mac)
1. Change to the `vaccine-spotter` directory; for example
      ```bash
      cd ~/Downloads/vaccine-spotter
      ```
   On macOS, if you don't know the exact path, you can just type `cd ` and then drag the folder from Finder into the Terminal window, then press return
1. Run `bundle` to install dependencies
1. Run `bundle exec ruby vaccine.rb --state <state code> --zipcodes <list of zipcodes>` to start
     > **Example**: `bundle exec ruby vaccine.rb --state CA --zipcodes 94022,94024`
     - `state` is the 2 letter abbreviation (examples: `CA`, `NY`, `IL`, etc)
     - `zipcodes` is a comma-separated list of zip codes, and you'll be alerted if there's a vaccine in any of them
1. Make sure your volume is ALL THE WAY UP so you can hear the beeps even if you're sleeping
