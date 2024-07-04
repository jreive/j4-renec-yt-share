source "https://rubygems.org"

ruby "3.3.2"

gem 'dotenv', groups: [:development, :test]

gem "rails", "~> 7.1.3", ">= 7.1.3.4"

gem 'devise', '~> 4.9', '>= 4.9.4'
gem 'devise-jwt', '~> 0.11.0'
gem 'validate_email', '~> 0.1.6'
gem 'will_paginate', '~> 4.0', '>= 4.0.1'

gem "sprockets-rails"

gem "sqlite3", "~> 1.4"

gem "puma", ">= 5.0"

gem "jsbundling-rails"

gem "turbo-rails"

gem "stimulus-rails"

gem "cssbundling-rails"

gem "jbuilder"

gem "net-pop", github: "ruby/net-pop"

# gem "redis", ">= 4.0.1"

# gem "kredis"

# gem "bcrypt", "~> 3.1.7"

gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "bootsnap", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'shoulda', '~> 5.0.0.rc1'
  gem "capybara"
  gem "selenium-webdriver"
end
