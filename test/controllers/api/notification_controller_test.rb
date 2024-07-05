require "test_helper"

class Api::NotificationControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "authenticated user should get correct response" do
    sign_in users(:user_admin)
    get :fetch
    assert_response :success

    list = response.parsed_body
    assert_equal 2, list["data"].length
    first = list["data"].find { |d| d["id"] == 2}
    assert_not_nil first
    assert_equal "Now what's upppp", first["title"]
    assert_equal false, first["read"]
    assert_equal "24 Hours Listening Practice Level 2", first["video"].try(:[], "title")

    seconds = list["data"].find { |d| d["id"] == 1}
    assert_not_nil seconds
    assert_equal "First video", seconds["title"]
    assert_equal false, seconds["read"]

    post :read, params: { id: 1 }
    assert_response :success

    post :read_all
    assert_response :success
  end

  test "unauthenticated user should get redirect" do
    get :fetch
    assert_response :redirect

    post :read
    assert_response :redirect

    post :read_all
    assert_response :redirect

    get :read
    assert_response :redirect

    get :read_all
    assert_response :redirect
  end

end
