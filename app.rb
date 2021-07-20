require "bundler"
Bundler.require

class App < Sinatra::Base
  configure :development do
    require "sinatra/reloader"
    register Sinatra::Reloader
  end

  configure do
  end

  helpers do
    def app(name)
      heroku_api.app.info(name)
    rescue Excon::Errors::Forbidden, Excon::Errors::NotFound
      halt(404)
    end

    def heroku_api
      halt(401) unless request.env["bouncer.token"]
      PlatformAPI.connect_oauth(request.env["bouncer.token"])
    end

    def log_url(app_id)
      log_session = heroku_api.log_session.create(app_id)
      log_session.fetch("logplex_url")
    rescue Excon::Errors::Forbidden, Excon::Errors::NotFound
      halt(404)
    end
  end

  get "/" do
    @apps = heroku_api.app.list.sort_by { |a| a["name"] }
    erb :index
  end

  get "/app/:id" do
    @app = app(params[:id])
    @app[:log_url] = log_url(params[:id])
    erb :app
  end
end
