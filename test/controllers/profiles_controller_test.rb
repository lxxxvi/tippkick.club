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

    put profile_path, params: {
      profile: {
        nickname: 'Maradona',
        rooting_for_team: 'ITA',
        locale: 'de-CH'
      }
    }

    assert_equal 'Maradona', user.nickname
    assert_equal 'ITA', user.rooting_for_team
    assert_equal 'de-CH', user.locale

    follow_redirect!
    assert_response :success
    assert_equal 'Profil erfolgreich gespeichert.', flash[:notice]
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
