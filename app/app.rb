class App < Sinatra::Base
    helpers AppHelper

    set :root, File.expand_path('../..', __FILE__)
    set :views, Proc.new { File.join(root, "app/views") }
    set :public_folder, Proc.new { File.join(root, "public") }
    set :erb, layout_options: {views: 'app/views/layouts'}
    enable :method_override
    enable :logging

    configure :development, :test do
        register Sinatra::Reloader
    end


    get "/" do
        # Get posts: posts = .... Order them by likes
        @posts = get_facebook_page_data().first(3)
        erb :main
    end
end
