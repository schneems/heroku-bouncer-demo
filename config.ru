require 'heroku/bouncer'
require './app'

STDOUT.sync = true

use Heroku::Bouncer,
  oauth: {
    id: ENV["HEROKU_OAUTH_ID"],
    secret: ENV["HEROKU_OAUTH_SECRET"],
    scope: "identity read"
  },
  secret: ENV["HEROKU_BOUNCER_SECRET"],
  expose_token: true
run App
