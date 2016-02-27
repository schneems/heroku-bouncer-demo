require 'heroku/bouncer'
require './app'

STDOUT.sync = true

use Rack::Session::Cookie, secret: ENV["COOKIE_SECRET"], key: "_demo_session"

use Heroku::Bouncer,
  oauth: {
    id: ENV["HEROKU_OAUTH_ID"],
    secret: ENV["HEROKU_OAUTH_SECRET"],
    scope: "identity read"
  },
  secret: ENV["HEROKU_BOUNCER_SECRET"],
  expose_token: true
run App
