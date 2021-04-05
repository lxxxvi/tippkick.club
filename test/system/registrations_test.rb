require 'application_system_test_case'

class RegistrationsTest < ApplicationSystemTestCase
  test 'joins team after signing up' do
    visit '/teams/tkid_campeones/join/campeones_token'
    click_on 'Sign up'

    fill_in 'Email', with: 'messi@tippkick.test'
    fill_in 'Password', with: 'messi'

    click_on 'Sign up'

    fill_in 'Nickname', with: 'Messi'
    click_on 'Save'

    assert_selector 'h1', text: 'Campeones'
  end
end
