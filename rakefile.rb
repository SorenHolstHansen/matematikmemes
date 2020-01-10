require './config/boot'

desc "This task scrapes the matematik memes facebook page and updates the database"
task :update_database do
    puts "Updating database..."
    update_database()
    puts "\ndone."
end
