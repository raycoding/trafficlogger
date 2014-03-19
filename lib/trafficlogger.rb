require "trafficlogger/engine"
require 'yaml'
module Trafficlogger
	class UAParse
		class << self
			def extract(ua_string)
				regexes_file = File.join(Trafficlogger::Engine.root,"lib/trafficlogger/regexes.yaml")
				ua_info = YAML.load_file(regexes_file)
				data = process ua_info
				os = extract_operating_system(data[1],ua_string)
				device = extract_device(data[2],ua_string)
				user_agent = extract_user_agent(data[0],ua_string)
				[os,device,user_agent]
			end

			def process(ua_info)
				ua_info.each_pair do |type, patterns|
	        patterns.each do |pattern|
	          pattern["regex"] = Regexp.new(pattern["regex"])
	        end
	      end
      	[ua_info["user_agent_parsers"],ua_info["os_parsers"],ua_info["device_parsers"]]
			end

			def extract_operating_system(os_parsers,str)
				pattern, match = match_first(os_parsers,str)
				if !match.nil?
					match.captures.first.present? ? match.captures.first : 'unidentifed'
				else
					'unidentifed'
				end
			end

			def extract_device(platform_parsers,str)
				pattern, match = match_first(platform_parsers,str)
				if !match.nil?
					match.captures.first.present? ? match.captures.first : 'unidentifed'
				else
					'unidentifed'
				end
			end

			def extract_user_agent(user_agent_parsers,str)
				pattern, match = match_first(user_agent_parsers,str)
				if !match.nil?
					name = match.captures.first
					if pattern["family_replacement"]
		        name = pattern["family_replacement"].sub('$1', name || '')
		      end
		      name.present? ? name : 'unidentifed'
				else
					'unidentifed'
				end
			end

			def match_first(patterns,str)
	      patterns.each do |p|
	        if m = p["regex"].match(str)
	          return [p,m]
	        end
	      end
	      nil
	    end
		end
	end
end
