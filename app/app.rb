class App < Sinatra::Base
    helpers AppHelper

    set :root, File.expand_path('../..', __FILE__)
    set :views, Proc.new { File.join(root, "app/views") }
    set :public_folder, Proc.new { File.join(root, "public") }
    set :erb, layout_options: {views: 'app/views/layouts'}
    set :db, File.join(root, "db")
    enable :method_override
    enable :logging

    configure :development do
        register Sinatra::Reloader
        ### SQlite in development
        ## DataMapper
        DataMapper.setup(:default, "sqlite3://#{settings.db}/development.db")
        ## Sequel
        # DB = Sequel.connect("sqlite://#{settings.db}/development.db")
    end

    configure :production do
        ### For Heroku deployment
        ## Activerecord
        # ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
        ## DataMapper
        DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
        ## Sequel
        # DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
    end

    configure :test do
        register Sinatra::Reloader
        ### SQlite in test
        ## DataMapper
        DataMapper.setup(:default, "sqlite3://#{settings.db}/test.db")
        ## Sequel
        # DB = Sequel.connect("sqlite://#{settings.db}/yesy.db")
    end

    get "/" do
        "go to <a href=\"/things\">things</a>"
    end
end
