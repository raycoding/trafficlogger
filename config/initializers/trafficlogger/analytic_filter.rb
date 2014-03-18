require 'rack'
module Trafficlogger
	class AnalyticFilter
		def initialize(app)
	    @app = app
	  end

	  def call(env)
	    status, headers, response = @app.call(env)
	    if !headers.nil? && !headers["Content-Type"].nil? && headers["Content-Type"].include?("text/html")
	      req = Rack::Request.new(env)
	      unless req.env["PATH_INFO"].starts_with?("/traffic_analytics")
	        Analytic.logger(req)
	      end
	    end
	    [status, headers, response]
	  end
	end
end