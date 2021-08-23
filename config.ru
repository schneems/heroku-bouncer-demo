require "dotenv/load"
require "heroku/bouncer"
require "./app"

STDOUT.sync = true

use Rack::Session::Cookie,
  secret: ENV["COOKIE_SECRET"],
  key: "_demo_session",
  same_site: :lax,
  secure: ENV.fetch("RACK_ENV", "development") == "production"

use Heroku::Bouncer,
  oauth: {
    id: ENV["HEROKU_OAUTH_ID"],
    secret: ENV["HEROKU_OAUTH_SECRET"],
    scope: "identity read"
  },
  secret: ENV["HEROKU_BOUNCER_SECRET"],
  expose_token: true,
  # Skip requests for our favicon. Thanks, Firefox.
  skip: ->(env) { %r{/images/heroku\.png}.match?(env["PATH_INFO"]) },
  login_path: "/login"

run App
