module Trafficlogger
  class Analytic < ActiveRecord::Base
    attr_accessible :server_name,:server_port,:server_software,:gateway_interface,:path_info,
										:request_uri,:query_string,:remote_host,:http_accept_encoding,
										:http_user_agent,:server_protocol,:http_accept_language,:http_host,
										:remote_addr,:http_referer,:http_cookie,:http_accept,
										:request_method,:http_connection,:http_version,:original_full_path

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
				Analytic.create(log_data)
			end

		  def search(searchterm,searchtype)
		    if !searchterm.blank? and !searchtype.blank?
		      case searchtype
		      when "path_info"
		        where("path_info = ?",searchterm).order("created_at desc")
		      when "original_full_path"
		        where("original_full_path = ?",searchterm).order("created_at desc")
		      when "request_uri"
		        where("request_uri = ?",searchterm).order("created_at desc")
		      when "http_user_agent"
		        where("http_user_agent LIKE ?","%#{searchterm}%").order("created_at desc")
		      when "request_method"
		        where("request_method = ?",searchterm).order("created_at desc")
		      else
		        order("created_at desc").scoped
		      end
		    else
		      order("created_at desc").scoped
		    end
		  end
		end
  end
end
