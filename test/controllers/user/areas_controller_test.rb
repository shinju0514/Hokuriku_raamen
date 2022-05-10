require "test_helper"

class User::AreasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_areas_index_url
    assert_response :success
  end

  test "should get create" do
    get user_areas_create_url
    assert_response :success
  end

  test "should get destroy" do
    get user_areas_destroy_url
    assert_response :success
  end
end
