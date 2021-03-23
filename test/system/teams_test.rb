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

  test 'admin deletes team' do
    before_tournament do
      sign_in_as :diego

      within 'section#teams' do
        click_on 'Campeones'
      end

      click_on 'Delete'
      assert_selector '.flash-messages', text: 'Team deleted successfully.'
      assert_selector 'h1', text: 'Dashboard'
    end
  end

  test 'non-admin cannot delete team' do
    before_tournament do
      memberships(:pele_campeones_invited).accept
      sign_in_as :pele

      within 'section#teams' do
        click_on 'Campeones'
      end

      assert_selector 'a', text: 'Delete', count: 0
    end
  end
end
