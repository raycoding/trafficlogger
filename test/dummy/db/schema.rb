# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140318181352) do

  create_table "trafficlogger_analytics", :force => true do |t|
    t.string   "server_name"
    t.string   "server_port"
    t.text     "server_software"
    t.string   "gateway_interface"
    t.string   "path_info"
    t.string   "original_full_path"
    t.string   "request_uri"
    t.string   "query_string"
    t.string   "remote_host"
    t.text     "http_accept_encoding"
    t.text     "http_user_agent"
    t.string   "server_protocol"
    t.string   "http_accept_language"
    t.string   "http_host"
    t.string   "remote_addr"
    t.text     "http_referer"
    t.string   "http_cookie"
    t.text     "http_accept"
    t.string   "request_method"
    t.string   "http_connection"
    t.string   "http_version"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "trafficlogger_analytics", ["original_full_path"], :name => "index_trafficlogger_analytics_on_original_full_path"
  add_index "trafficlogger_analytics", ["path_info"], :name => "index_trafficlogger_analytics_on_path_info"
  add_index "trafficlogger_analytics", ["request_method"], :name => "index_trafficlogger_analytics_on_request_method"
  add_index "trafficlogger_analytics", ["request_uri"], :name => "index_trafficlogger_analytics_on_request_uri"
  add_index "trafficlogger_analytics", ["server_name"], :name => "index_trafficlogger_analytics_on_server_name"

end
