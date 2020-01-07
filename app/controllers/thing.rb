class ThingController < App
    
    set :views, Proc.new { File.join(root, "app/views/thing") }

    get '/' do
        title "Things"
        @things = Thing.all
        erb :index
    end

    get '/new/?' do
        @thing = Thing.new
        erb :new
    end

    get '/:id/?' do
        @thing = Thing.get(params[:id])
        erb :show
    end

    get '/:id/edit/?' do
        @thing = Thing.get(params[:id])
        erb :edit
    end

    put '/:id/?' do
        thing = Thing.get(params[:id]).update(params[:thing])
        redirect to("/")
    end

    post '/?' do
        thing = Thing.create(params[:thing])
        redirect to("/")
    end

    delete '/:id/?' do
        Thing.get(params[:id]).destroy

        redirect to("/")
    end
end
