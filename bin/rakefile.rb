desc "This task scrapes the matematik memes facebook page and updates the database"
task :update_database => :environment do
    puts "Updating database..."
    update_database()
    puts "done."
end