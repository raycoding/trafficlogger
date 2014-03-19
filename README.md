## Trafficlogger

Trafficlogger is a Rails Engine with Rack Middleware to track HTTP Requests on your site and log them.
The gem tracks incoming HTTP requests coming to your site and logs them with detailed information about the Request into DB Table for Analysis.Every incoming requests where Content Type is `text/html` gets logged with detailed information about the request
- SERVER_NAME
- PATH_INFO
- REMOTE_HOST
- HTTP_ACCEPT_ENCODING
- HTTP_USER_AGENT
- HTTP_HOST
- REMOTE_ADDR
- SERVER_SOFTWARE
- HTTP_REFERER
- HTTP_COOKIE
- REQUEST_URI
- SERVER_PORT
- GATEWAY_INTERFACE
- QUERY_STRING
- REQUEST_METHOD
- HTTP_CONNECTION
And More!

Also it has inbuilt parser to extract Operating System,Platform,Device from HTTP_USER_AGENT. When the logger runs the Parser auto-extracts these information wherever applicable. Neverthless you can re-use the component yourself in your App anytime by running 
`Trafficlogger::UAParse.extract(your_string)`
Example => `Trafficlogger::UAParse.extract('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_3) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.151 Safari/535.19')`

## Demonstration

Sample App - https://github.com/raycoding/rTracker

Once integrated with your App you can see the log entries in DB Table and also there is Search Analytics Dashboard which will be located at URL `/tracklogger` inside your Application

## Installation Steps 

 -  In your Gemfile 
    `gem 'trafficlogger'`

 -  `bundle install`

 -	routes.rb
 		Add the following line `mount Trafficlogger::Engine => "/trafficlogger"`

 -	After you run your app's `rake:db:migrate` run `rake trafficlogger:install:migrations`
 		This is will copy all necessary migrations from Trafficlogger Engine to your app, post which run 
 		`rake:db:migrate` again, this will not run migrations from engine.

 -  In your `config/application.rb`
    Add the following line `config.middleware.use 'Trafficlogger::AnalyticFilter'`
    This will add the Rack Middleware from Trafficlogger Engine in your App.

 - You are all set!


## Dependencies

  - Ruby 1.9.3+
  - Rails 3.2.13
  - will_paginate

### ToDo

 Porting this for Rails 2.x is not difficult as only few scope conditions at model level needs to changed ; which are for Rails 3 but does not work for Rails 2, feel free to fork it and contribute for Rails 2.x platforms, also it should work on Ruby 1.8.7+