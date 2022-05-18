require "test_helper"

class User::MapsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_maps_index_url
    assert_response :success
  end
end
