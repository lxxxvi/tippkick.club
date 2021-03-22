require 'application_system_test_case'

class TeamsTest < ApplicationSystemTestCase
  test 'create team' do
    before_tournament do
      sign_in_as :diego

      within 'section#teams' do
        click_on 'Create new team'
      end

      fill_in 'Name', with: 'Argentinos'
      click_on 'Create Team'

      assert_selector 'h1', text: 'Argentinos'
      assert_selector '.active-members', text: '1'
    end
  end
end
