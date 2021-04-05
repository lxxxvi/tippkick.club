require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test 'redirect to profile path after simple sign up' do
    post user_registration_path, params: {
      user: {
        email: 'messi@tippkick.test',
        password: 'lionel'
      }
    }

    assert_redirected_to profile_path
    follow_redirect!
    assert_response :success

    assert_equal 'Welcome! You have signed up successfully.', flash[:notice]

    put profile_path, params: {
      profile: {
        nickname: 'Messi'
      }
    }

    assert_redirected_to dashboard_path
    follow_redirect!
    assert_response :success

    assert_equal 'Profile updated successfully.', flash[:notice]
  end

  test 'redirect to profile path after simple sign up, redirect to teams path to join' do
    team = teams(:campeones)
    get join_team_url(team, 'campeones_token') # stores the path in devise
    get new_user_registration_path

    post user_registration_path, params: {
      user: {
        email: 'messi@tippkick.test',
        password: 'lionel'
      }
    }

    assert_redirected_to profile_path(redirect_to_path: '/teams/tkid_campeones/join/campeones_token')
    follow_redirect!
    assert_response :success

    put profile_path, params: {
      profile: {
        nickname: 'Messi',
        redirect_to_path: '/teams/tkid_campeones/join/campeones_token'
      }
    }

    assert_redirected_to '/teams/tkid_campeones/join/campeones_token'
    follow_redirect!

    assert_redirected_to '/teams/tkid_campeones'
    follow_redirect!
    assert_response :success

    assert_equal 'Joined team successfully.', flash[:notice]
  end
end
