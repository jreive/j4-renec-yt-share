require "test_helper"

class Api::YoutubeVideosControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "un-authorize should get redirect" do
    get :index
    assert_response :redirect

    get :get_by_id, params: { id: 1 }
    assert_response :redirect

    get :latest_video
    assert_response :redirect

    post :create
    assert_response :redirect

    post :watched
    assert_response :redirect
  end

  test "error if missing or invalid params" do
    sign_in users(:user_admin)

    post :create
    assert_response :internal_server_error

    post :watched
    assert_response :internal_server_error

    post :create, params: { url: 'https://www.youtube.com/watch?v=Xs-GCJwz4PnY' }
    assert_response :unprocessable_entity

    post :create, params: { url: 'https://youtu.be/X-GCJswz4PnY?si=AsSdAzWYoLvKTVM19' }
    assert_response :unprocessable_entity
  end

  test "authorize should get correct response" do
    sign_in users(:user_admin)

    get :index
    assert_response :ok
    list = response.parsed_body
    assert_equal 2, list["data"]["total"]
    assert_equal 2, list["data"]["videos"].length

    get :get_by_id, params: { id: 1 }
    assert_response :ok

    get :latest_video
    assert_response :ok

    post :create, params: { url: 'https://www.youtube.com/watch?v=X-GCJwz4PnY' }
    assert_response :created

    post :create, params: { url: 'https://youtu.be/X-GCJwz4PnY?si=ASdAzWYoLvKTVM19' }
    assert_response :created
  end

end
