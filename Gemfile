source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '4.2.7.1'

# assets pipline
  gem 'sass-rails', '~> 4.0.3'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'jquery-rails'
  gem 'turbolinks'
  gem 'jbuilder', '~> 2.0'
  gem "js-routes"
  gem "nprogress-rails", "~> 0.1.2.3"
# handle react assets
  gem 'react-rails', '~> 1.8.2'
  gem 'sprockets-coffee-react'

group :doc do
  gem 'sdoc', '~> 0.4.0'
end

group :development, :test do
  # handle live perform RSpec
    gem 'guard'
    gem 'guard-livereload'
    gem 'guard-rspec'
  # handle testing library
    gem 'rspec-rails'
    gem 'factory_girl_rails'
    gem 'database_cleaner'
    gem 'shoulda-matchers'
    gem 'simplecov', require: false
  # handle features testing
    gem 'capybara'
    gem 'selenium-webdriver', '2.45.0' # Please use firefox version 27.0
  # handle quality of code
    gem 'rubycritic', :require => false
  # handle beauty rails console
    gem 'pry-rails'
    
  gem 'spring'
end

group :development do
  # handle error debugging
    gem 'binding_of_caller'
    gem 'better_errors'
  # handle clean logs
    gem 'quiet_assets'
  # handle beauty console
    gem 'awesome_print'
  # handle schema model documentation
    gem 'annotate'
end

# handle server
  gem 'puma'
# handle view template
  gem 'slim'
# handle database
  gem 'sqlite3'
# handle text editor
  gem "bootstrap-wysihtml5-rails"
# handle match sentence
  gem 'fuzzy-string-match'
  gem 'numbers_and_words'
