require 'application_system_test_case'

class ProfileTest < ApplicationSystemTestCase
  test 'changes profile' do
    before_tournament do
      sign_in_as :diego

      within('section#profile') do
        click_on 'Profile'
      end

      assert_field 'Nickname', with: 'digi'
      fill_in 'Nickname', with: 'Diego'

      select 'France', from: 'Rooting for team'
      click_on 'Save'
      assert_field 'Nickname', with: 'Diego'
    end
  end

  test 'sees profile through profile menu' do
    using_browser do
      sign_in_as :diego

      within('#profile-menu') do
        click_button
        click_on 'Profile'
      end

      assert_selector 'h1', text: 'PROFILE'
    end
  end
end
