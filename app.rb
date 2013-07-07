require 'bundler'
Bundler.require

class App < Sinatra::Base

  configure :development do
    require "sinatra/reloader"
    register Sinatra::Reloader
  end

  configure do

  end

  helpers do
    # Heroku API
    def api
      halt(401) unless request.env['bouncer.token']
      Heroku::API.new(api_key: request.env['bouncer.token'])
    end

    def app(name)
      api.get_app(name).body
    rescue Heroku::API::Errors::Forbidden, Heroku::API::Errors::NotFound
      halt(404)
    end

    def log_url(name)
      api.get_logs(name, {'tail' => 1, 'num' => 1500}).body
    rescue Heroku::API::Errors::Forbidden, Heroku::API::Errors::NotFound
      halt(404)
    end
  end

  get "/" do
    @apps = api.get_apps.body.sort{|x,y| x["name"] <=> y["name"]}
    erb :index
  end

  get "/app/:id" do
    @app = app(params[:id])
    @app.merge!(log_url: log_url(params[:id]))
    erb :app
  end
end
