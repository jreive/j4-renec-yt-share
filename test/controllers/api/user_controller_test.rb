require "test_helper"

class Api::UserControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "un-authorize should get redirect" do
    get :validate
    assert_response :redirect

    post :validate
    assert_response :redirect
  end

  test "authorize should get response" do
    sign_in users(:user_admin)

    get :validate
    assert_response :ok

    post :validate
    assert_response :ok
  end

  test "check valid missing email get error" do
    get :check
    assert_response :internal_server_error

    post :check
    assert_response :internal_server_error
  end

  test "check valid email get success" do
    post :check, params: { email: "admin@example.com" }
    assert_response :ok
  end

  test "duplicate email get error" do
    post :check, params: { email: "admin@mail.com" }
    assert_response :unprocessable_entity
  end

end
