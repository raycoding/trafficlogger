require_dependency "trafficlogger/application_controller"

module Trafficlogger
  class TrafficAnalyticsController < ApplicationController
    def index
    	@records = Analytic.find_listings(params).paginate(:page => params[:page],:per_page => 10)
    end
  end
end