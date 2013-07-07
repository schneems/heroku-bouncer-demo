require 'heroku/bouncer'
require './app'

STDOUT.sync = true

use Heroku::Bouncer, expose_token: true
run App
