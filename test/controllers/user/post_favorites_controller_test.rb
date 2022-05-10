require "test_helper"

class User::PostFavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_post_favorites_create_url
    assert_response :success
  end

  test "should get destroy" do
    get user_post_favorites_destroy_url
    assert_response :success
  end
end
