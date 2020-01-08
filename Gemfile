source 'https://rubygems.org'

gem 'sinatra'
gem 'sinatra-contrib'

## ORM : DataMapper ##
gem 'dm-validations'
gem 'dm-timestamps'
gem 'dm-migrations'
gem 'dm-constraints'
gem 'dm-aggregates'
gem 'dm-types'
gem 'dm-core'

group :production do
    gem 'pg'
    gem 'dm-postgres-adapter'
end

group :development do
    gem 'dm-sqlite-adapter'
end

## Test ##
group :test do
    ## Rack::Test ##
    gem 'rack-test'
    ## Rspec ##
    gem 'rspec'
    ## Minitest ##
end

## SASS ##
gem 'sass'
