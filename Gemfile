source 'https://rubygems.org'
ruby '2.0.0'
#test
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'


gem 'pg'

# Send logs to stdout for heroku
gem 'rails_12factor', group: :production

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use rambling-slider image carousel
gem 'rambling-slider-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

group :doc do
  gem 'yard'
  gem 'yardstick'
  gem 'yard-activerecord'
  gem 'annotate'
end

# Use ActiveModel has_secure_password
gem 'bcrypt'
# Prevent heroku errors from missing authlogic dependency
gem 'scrypt' 

group :test do
	gem 'turn'	# Display test output in pretty colors
	gem 'simplecov', '~> 0.7.1', require: false
end

group :development, :test do
	gem 'minitest-rails'
	gem 'minitest-spec-rails'
	gem 'factory_girl_rails'
	gem 'faker'	
	# Mocks and stubs for testing
	gem 'mocha', :require => false
end

# Provides simple page authorization
gem 'cancancan', '~> 1.7'

# Require authlogic for passwords - omniauth provides support to login with facebook, google+, and twitter support
gem 'authlogic'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem "omniauth-google-oauth2"

# Use Geocoder to help with address and coordinate information --> [AC] Suggestion, but not yet installed
gem 'geocoder'
# Use Google Maps For Rails for map display
gem 'gmaps4rails'

# Use Carrierwave for image uploads and display
gem 'carrierwave'

#twitter bootstrap
gem 'bootstrap-sass'
gem 'bootstrap_form'

group :development do
  gem 'rails_layout'
	
	# Display better errors and allow troubleshooting directly in browser if errors are caught in the code
  gem 'better_errors'
  gem 'binding_of_caller' 
end
