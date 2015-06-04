# WithCleanRbenv

Prepare a bare-enviroment for nested rbenv.

This gem is based on this article.

* [rbenv のメカニズム - @kyanny&#39;s blog](http://blog.kyanny.me/entry/2013/05/10/rbenv_%E3%81%AE%E3%83%A1%E3%82%AB%E3%83%8B%E3%82%BA%E3%83%A0)

[![Build Status](https://travis-ci.org/troter/with_clean_rbenv.svg?branch=master)](https://travis-ci.org/troter/with_clean_rbenv)
[![Coverage Status](https://coveralls.io/repos/troter/with_clean_rbenv/badge.svg)](https://coveralls.io/r/troter/with_clean_rbenv)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'with_clean_rbenv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install with_clean_rbenv

## Usage

```ruby
require 'with_clean_rbenv'

WithCleanRbenv.with_clean_rbenv do
  Dir.chdir '/path/to/other/ruby/project' do
    system('rbenv exec bundle exec ruby -v')
  end
end

# or short
WithCleanRbenv.within_clean_rbenv '/path/to/other/ruby/project' do
  system('rbenv exec bundle exec ruby -v')
end

```

If you need to set custom environment variables:

```ruby
context = WithCleanRbenv::Context.new('GEM_HOME' => nil)

context.with_clean_rbenv do
  system('rbenv exec bundle exec ruby -v')
end
```

If you want to replace default context:

```ruby
# Replace default context.
WithCleanRbenv.current = WithCleanRbenv::Context.new('GEM_HOME' => nil)

WithCleanRbenv.with_clean_rbenv do
  system('rbenv exec bundle exec ruby -v')
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/troter/with_clean_rbenv/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
