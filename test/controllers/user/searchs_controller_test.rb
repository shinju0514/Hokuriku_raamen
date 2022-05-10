require "test_helper"

class User::SearchsControllerTest < ActionDispatch::IntegrationTest
  test "should get search_area" do
    get user_searchs_search_area_url
    assert_response :success
  end

  test "should get search_tag" do
    get user_searchs_search_tag_url
    assert_response :success
  end

  test "should get search_post" do
    get user_searchs_search_post_url
    assert_response :success
  end

  test "should get search_shop" do
    get user_searchs_search_shop_url
    assert_response :success
  end
end
