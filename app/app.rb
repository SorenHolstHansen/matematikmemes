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
        "go to <a href=\"/things\">things</a>"
    end
end
