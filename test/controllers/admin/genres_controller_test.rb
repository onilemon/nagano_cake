require "test_helper"

class Admin::GenresControllerTest < ActionDispatch::IntegrationTest
  test "should get admin/customers" do
    get admin_genres_admin/customers_url
    assert_response :success
  end

  test "should get admin/orders" do
    get admin_genres_admin/orders_url
    assert_response :success
  end

  test "should get admin/order_details" do
    get admin_genres_admin/order_details_url
    assert_response :success
  end
end
