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
        DataMapper.setup(:default, "sqlite3://#{settings.db}/development.db")
    end

    configure :production do
        DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
    end

    configure :test do
        register Sinatra::Reloader
        DataMapper.setup(:default, "sqlite3://#{settings.db}/test.db")
    end


    get "/" do
        @posts = Post.all(:order => [ :reactions.desc ],:limit => 50)
        erb :main
    end

    get "/om" do
        erb :about
    end
end
