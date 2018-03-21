# Harmonics Helper

This is tools to help learning 4 parts harmonics who use score making application.
Harmonics contains many prohibition and it's difficult to find prohibitations for learner.
This tool check prohibitition or some important things from MusicXML files - most of the score making application describe score as this format internal and user can export MusicXML easily-

---

### Usage

```rb
# input MusicXML Format
formatter = HarmonicsHelper::ProhibitFormatter.new(xml)
# get prohibit info
prohibit_info = formatter.prohibit_info
```

Example of Prohibits Info

```
{"prohibit_info"=>
  [{"all_prohibit"=>["result check all prohibit", "[Failure] Prohibits may be exist, please check yourself again", 
  {"consecutive_prohibit"=>["result check consecutive octave or fifth", "[Failure] Prohibits may be exist, please check yourself again", ["--OK--", "--OK--", "--OK--", "--OK--", "!!NG!!", "--OK--", "--OK--", "--OK--", "!!NG!!", "--OK--"], ["--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--"], ["--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "!!NG!!", "--OK--"], ["--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--"], ["--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--"], ["--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--"]]}, 
  {"code_prohibit"=>["result check codes are fulfilled", "[Failure] Prohibits may be exist, please check yourself again", ["--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "--OK--", "!!NG!!", "--OK--"]]}]}
```

### TODO

It is trial version now
Consecutive octave and fifth, open fifth only now

- correct validate
- single part prohibit
- hidden prohibit
- part distance prohibit
- part range prohibit
- fix bug
- format output
- decide code name
- take account non harmonics tone
- if sound duration is different
- case not four part

etc

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/harmonics_helper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
