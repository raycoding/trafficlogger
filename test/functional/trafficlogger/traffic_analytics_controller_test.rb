require 'test_helper'

module Trafficlogger
  class TrafficAnalyticsControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end
  
  end
end
