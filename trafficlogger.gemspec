$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "trafficlogger/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "trafficlogger"
  s.version     = Trafficlogger::VERSION
  s.authors     = ["Shuddhashil Ray"]
  s.email       = ["rayshuddhashil@gmail.com"]
  s.homepage    = "https://github.com/raycoding/trafficlogger"
  s.summary     = "Trafficlogger is a Rails Engine with Rack Middleware to track HTTP Requests on your site and log them"
  s.description = "Trafficlogger is a Rails Engine with Rack Middleware to track incoming HTTP requests coming to your site and logs them with detailed information about the Request"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2"
  s.required_ruby_version = '>= 1.9.2' #may be on 1.8.7!
  s.add_dependency "rack","~>1.4"
  s.add_dependency "will_paginate", "~>3.0"
  s.add_dependency "jquery-ui-rails", "~>4.0"
end
