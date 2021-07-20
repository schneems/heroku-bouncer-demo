## Heroku API example With Heroku Bouncer

Want to use the Heroku API to authenticate a user to let them do something with Heroku?
With [heroku-bouncer](https://github.com/heroku/heroku-bouncer) and [Platform API](https://github.com/heroku/platform-api) it's super simple.

## General Idea

Start up the server, any endpoint will redirect you to an authentication page for Heroku.
Once authorized, visit `/` and you'll see a list of all your apps.
Click on an app for more info.

It's purposefully bare bones, but a good place to get started with a basic Heroku API backed app.

## Install

Clone the repo then run:

```console
$ bundle install
```

Then create a `.env` file:

```console
$ touch .env
```

Next you need to set up your OAuth.

### Set up OAuth

This project uses OAuth to obtain authorization to fetch your application’s logs using the Heroku API.
To make this work, you have to register an OAuth client with Heroku.
The easiest way to do this is on your [account page on the Heroku Dashboard](https://dashboard.heroku.com/account).
Enter `http://localhost:5000/auth/heroku/callback` when prompted for a callback URL.
The [OAuth developer doc](https://devcenter.heroku.com/articles/oauth) has additional details on client creation and OAuth in general.

When registering the client you get an OAuth client id and secret.
Add these as `HEROKU_OAUTH_ID` and `HEROKU_OAUTH_SECRET` environment variables to your application’s `.env`.
You will also need two randomly generated values, `HEROKU_BOUNCER_SECRET` and `COOKIE_SECRET`.

```shell
HEROKU_OAUTH_ID=asdf...
HEROKU_OAUTH_SECRET=asdf...
HEROKU_BOUNCER_SECRET=asdf...
COOKIE_SECRET=asdf...
```

## Start the Server

```console
$ heroku local:start
```

## Thanks

To [dominic](https://github.com/dominic) and the [log2viz](https://github.com/heroku/log2viz) project for some good code.
