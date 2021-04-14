require 'test_helper'

class AboutControllerTest < ActionDispatch::IntegrationTest
  test 'get show' do
    get about_path
    assert_response :success
  end
end
