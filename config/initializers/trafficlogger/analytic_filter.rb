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
	      unless req.env["REQUEST_URI"].include?("trafficlogger")
	        Analytic.logger(req)
	      end
	    end
	    [status, headers, response]
	  end
	end
end