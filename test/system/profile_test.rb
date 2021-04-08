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

      assert_selector '.flash-messages', text: 'Profile updated successfully.'
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
      assert_link 'Dashboard', href: '/dashboard'
    end
  end

  test 'changes profile langauge' do
    before_tournament do
      sign_in_as :zinedine

      within('section#profile') do
        click_on 'Profile'
      end

      select 'German (Switzerland)', from: 'Language'
      click_on 'Save'

      assert_selector '.flash-messages', text: 'Profil erfolgreich gespeichert.'
      navigate_to 'Turnier'
    end
  end
end
