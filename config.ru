require './config/boot.rb'

# Sass
#Sass::Plugin.options[:style] = :compressed
#use Sass::Plugin::Rack

map('/') { run App }
map('/things') { run ThingController }
