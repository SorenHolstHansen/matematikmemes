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
        # Get posts: posts = .... Order them by likes
        @posts = Post.all(:order => [ :reactions.desc ],:limit => 10)
        erb :main
    end
end
