Trafficlogger::Engine.routes.draw do
	get "traffic_analytics/index"
	root :to => 'traffic_analytics#index'
end
