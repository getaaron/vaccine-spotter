# vaccine-spotter

checks [COVID-19 Vaccine Spotter](https://www.vaccinespotter.org) for COVID-19 vaccine every 2 seconds

beeps a bunch when it finds one

## prerequisites

you need to have ruby

 - [mac instructions](https://stackify.com/install-ruby-on-your-mac-everything-you-need-to-get-going/)
 - [windows instructions](https://stackify.com/install-ruby-on-windows-everything-you-need-to-get-going/)

after you install ruby, you also need to install bundler; run this in your command line

```
gem install bundler
```

## short instructions (if you're familiar with ruby / command line tools)

1. clone repo
2. `bundle`
3. edit `state`, `closest_zip`, and `zips_i_want` variables in `vaccine.rb`
4. `bundle exec ruby vaccine.rb`

## longer instructions (if this stuff is alien to you

1. clone this repo or [download as a .zip file](https://github.com/getaaron/vaccine-spotter/archive/refs/heads/main.zip)
2. open a command line tool (e.g. Terminal.app / iTerm.app on Mac)
3. change to the `vaccine-spotter` directory; for example
      ```bash
      cd ~/Downloads/vaccine-spotter
      ```
   On Mac, if you don't know the exact path, you can just type `cd ` and then drag the folder from Finder into the Terminal window, then press return
4. run `bundle` to install dependencies
5. open `vaccine.rb` in any text editor, like Atom, VSCode, or TextEdit
6. edit `state` to your state's 2-letter code like `CA`, `IL`, `NY`, `FL`, etc.
7. edit `closest_zip` to zip code where you live
8. edit `zips_i_want` to an array of zips; you'll be alerted if there's a vaccine in any of them
9. run `bundle exec ruby vaccine.rb`
10. make sure your volume is ALL THE WAY UP so you can hear the beeps even if you're sleeping
