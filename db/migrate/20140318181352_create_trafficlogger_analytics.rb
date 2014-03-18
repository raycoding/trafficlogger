class CreateTrafficloggerAnalytics < ActiveRecord::Migration
  def change
    create_table :trafficlogger_analytics do |t|
    	t.string :server_name
  		t.string :server_port
  		t.text   :server_software
  		t.string :gateway_interface
  		t.string :path_info
      t.string :original_full_path
  		t.string :request_uri
  		t.string :query_string
  		t.string :remote_host
  		t.text   :http_accept_encoding
  		t.text   :http_user_agent
  		t.string :server_protocol
  		t.string :http_accept_language
  		t.string :http_host
  		t.string :remote_addr
  		t.text   :http_referer
  		t.string :http_cookie
  		t.text   :http_accept
  		t.string :request_method
  		t.string :http_connection
      t.string :http_version
      t.timestamps
    end
    add_index :trafficlogger_analytics, :server_name
    add_index :trafficlogger_analytics, :request_method
  	add_index :trafficlogger_analytics, :request_uri
  	add_index :trafficlogger_analytics, :path_info
    add_index :trafficlogger_analytics, :original_full_path
  end
end
