require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/reloader'
require 'dm-core'
require 'dm-migrations'
require 'sass'
require 'sass/plugin/rack'

Dir.glob('./app/helpers/*.rb').each { |file| require file }
require './app/app'
Dir.glob('./app/models/*.rb').each { |file| require file }
Dir.glob('./lib/*.rb').each { |file| require file }

DataMapper.finalize
DataMapper.auto_upgrade!

# update_database()
