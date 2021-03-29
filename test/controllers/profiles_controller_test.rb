require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test 'get show' do
    sign_in_as :diego

    get profile_path
    assert_response :success
  end

  test 'put update' do
    user = users(:diego)
    sign_in_as :diego

    assert_changes -> { user.reload.nickname }, to: 'Maradona' do
      put profile_path, params: {
        profile: {
          nickname: 'Maradona'
        }
      }
    end

    follow_redirect!
    assert_response :success
    assert_equal 'Profile updated successfully.', flash[:notice]
  end

  test 'put update, errors' do
    user = users(:diego)
    sign_in_as :diego

    assert_no_changes -> { user.reload.nickname } do
      put profile_path, params: {
        profile: {
          nickname: 'pele'
        }
      }
    end

    assert_response :success
    assert_equal 'Could not update profile.', flash[:alert]
  end
end
