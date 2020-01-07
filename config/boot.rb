require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/reloader'
require 'sass'
require 'sass/plugin/rack'

Dir.glob('./app/helpers/*.rb').each { |file| require file }
require './app/app'
Dir.glob('./lib/*.rb').each { |file| require file }

Dir.glob('./app/controllers/*.rb').each { |file| require file }
