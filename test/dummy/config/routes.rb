Rails.application.routes.draw do

  mount Trafficlogger::Engine => "/trafficlogger"
end
