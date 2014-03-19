module Trafficlogger
  class Analytic < ActiveRecord::Base
    attr_accessible :server_name,:server_port,:server_software,:gateway_interface,:path_info,
										:request_uri,:query_string,:remote_host,:http_accept_encoding,
										:http_user_agent,:server_protocol,:http_accept_language,:http_host,
										:remote_addr,:http_referer,:http_cookie,:http_accept,
										:request_method,:http_connection,:http_version,:original_full_path,
										:platform,:device,:operating_system

		class << self
			def logger(req=nil)
				return if req.nil? || req.env.nil?
				data = req.env
				log_data = {}
				log_data["server_name"] = data["SERVER_NAME"]
				log_data["server_port"] = data["SERVER_PORT"]
				log_data["server_software"] = data["SERVER_SOFTWARE"]
				log_data["gateway_interface"] = data["GATEWAY_INTERFACE"]
				log_data["path_info"] = data["PATH_INFO"]
				log_data["request_uri"] = data["REQUEST_URI"]
				log_data["query_string"] = data["QUERY_STRING"]
				log_data["remote_host"] = data["REMOTE_HOST"]
				log_data["http_accept_encoding"] = data["HTTP_ACCEPT_ENCODING"]
				log_data["http_user_agent"] = data["HTTP_USER_AGENT"]
				log_data["server_protocol"] = data["SERVER_PROTOCOL"]
				log_data["http_accept_language"] = data["HTTP_ACCEPT_LANGUAGE"]
				log_data["http_host"] = data["HTTP_HOST"]
				log_data["remote_addr"] = data["REMOTE_ADDR"]
				log_data["http_referer"] = data["HTTP_REFERER"]
				log_data["http_cookie"] = data["HTTP_COOKIE"]
				log_data["http_accept"] = data["HTTP_ACCEPT"]
				log_data["request_method"] = data["REQUEST_METHOD"]
				log_data["http_connection"] = data["HTTP_CONNECTION"]
				log_data["http_version"] = data["HTTP_VERSION"]
				log_data["original_full_path"] = data["ORIGINAL_FULLPATH"]
				# Extract Relevant Information from User Agent
				operating_system,device,platform = ::Trafficlogger::UAParse.extract data["HTTP_USER_AGENT"].to_s
				log_data["operating_system"] = operating_system
				log_data["device"] = device
				log_data["platform"] = platform

				Analytic.create(log_data)
			end

			attr_accessor :data
		  def find_listings params
		    @data = params
		    Rails.logger.info "Search Parameters passed for Trafficlogger Analytic ----> #{params.inspect}"
		    @records_listing = find_records
		    @records_listing
		  end

		  def find_records
		    Analytic.where(conditions).order("created_at DESC")
		  end

		  def path_info_inline_search_clause
		    unless data['path_info_inline_search'].blank?
		      ["trafficlogger_analytics.path_info LIKE ?", "%#{data['path_info_inline_search'][0]}%"]
		    end
		  end

		  def path_info_clause
		    ["trafficlogger_analytics.path_info = ?", "#{data['path_info_search']}"] unless data['path_info_search'].blank?
		  end

		  def request_uri_clause
		    ["trafficlogger_analytics.request_uri = ?", "#{data['request_uri_search']}"] unless data['request_uri_search'].blank?
		  end

		  def request_method_clause
		    ["trafficlogger_analytics.request_method = ?", "#{data['request_method_search']}"] unless data['request_method_search'].blank?
		  end

		  def operating_system_clause
		    ["trafficlogger_analytics.operating_system = ?", "#{data['operating_system_search']}"] unless data['operating_system_search'].blank?
		  end

		  def device_clause
		    ["trafficlogger_analytics.device = ?", "#{data['device_search']}"] unless data['device_search'].blank?
		  end

		  def platform_clause
		    ["trafficlogger_analytics.platform = ?", "#{data['platform_search']}"] unless data['platform_search'].blank?
		  end

		  def minimum_created_at_clause
		    unless data['minimum_created_at_search'].blank?
		      minimum_created_at_search = data['minimum_created_at_search'].to_date.strftime("%Y-%m-%d")
		      ["DATE(trafficlogger_analytics.created_at) >= DATE(?)", "#{minimum_created_at_search}"]
		    end
		  end

		  def maximum_created_at_clause
		    unless data['maximum_created_at_search'].blank?
		      maximum_created_at_search = data['maximum_created_at_search'].to_date.strftime("%Y-%m-%d")
		      ["DATE(trafficlogger_analytics.created_at) <= DATE(?)", "#{maximum_created_at_search}"]
		    end
		  end

		  def conditions
		    [conditions_clauses.join(' AND '), *conditions_options]
		  end

		  def conditions_clauses
		    conditions_parts.map { |condition| condition.first }
		  end

		  def conditions_options
		    conditions_parts.map { |condition| condition[1..-1] }.flatten
		  end

		  def conditions_parts
		    singleton_methods.grep(/_clause$/).map { |m| send(m) }.compact
		  end
		end
  end
end
