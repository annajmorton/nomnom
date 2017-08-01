source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.0'
gem 'hanami-model', '~> 1.0'

gem 'pg'

gem 'hanami-shrine', '0.2.1'
gem 'image_processing'
gem "mini_magick", ">= 4.3.5"

gem 'omniauth-github'
gem 'warden'

gem 'scrypt'
gem 'omniauth-hanami', github: 'katafrakt/omniauth-hanami'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
  gem 'pry'
end

group :test do
  gem 'minitest'
  gem 'capybara'
  gem 'minitest-reporters'
end

group :production do
  # gem 'puma'
end
ruby '2.3.0'
ruby '2.4.0'
