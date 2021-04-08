require 'application_system_test_case'

class TeamsTest < ApplicationSystemTestCase
  test 'displays teams' do
    before_tournament do
      sign_in_as :diego

      navigate_to 'Teams'

      assert_link 'Dashboard', href: '/dashboard'

      within('table') do
        assert_selector 'td', text: 'Campeones'
        assert_selector 'td', text: 'Global'
      end

      assert_selector '.create-team', text: 'Create new team'
    end
  end

  test 'create team' do
    before_tournament do
      sign_in_as :diego

      navigate_to 'Teams'
      click_on 'Create new team'
      fill_in 'Name', with: 'Argentinos'
      click_on 'Create team'

      assert_selector 'input[name=invitation_link]'
      assert_selector '.flash-messages', text: 'Team created successfully.'
      assert_selector 'h1', text: 'Argentinos'
    end
  end

  test 'show team and memberships' do
    before_tournament do
      sign_in_as :diego

      navigate_to 'Teams'
      click_on 'Campeones'

      assert_link 'Teams', href: '/teams'

      assert_selector 'h2', text: 'Your ranking in this team'
      assert_selector 'h2', text: 'Members'
      assert_selector 'h2', text: 'Admin'

      within 'table.team-memberships' do
        assert_selector 'td', text: 'digi'
        assert_selector 'td', text: 'pele'
      end
    end
  end

  test 'coach deletes team' do
    before_tournament do
      sign_in_as :diego

      navigate_to 'Teams'
      click_on 'Campeones'
      click_on 'Delete'

      assert_selector '.flash-messages', text: 'Team deleted successfully.'
      assert_selector 'h1', text: 'your dashboard'
    end
  end

  test 'non-coach cannot delete team' do
    before_tournament do
      sign_in_as :pele

      navigate_to 'Teams'
      click_on 'Campeones'

      assert_selector 'a', text: 'Delete', count: 0
    end
  end

  test 'coach edits team' do
    before_tournament do
      sign_in_as :diego

      navigate_to 'Teams'
      click_on 'Campeones'
      click_on 'Edit'
      fill_in 'Name', with: 'The Champions'
      click_on 'Update team'

      assert_selector '.flash-messages', text: 'Team updated successfully.'
      assert_selector 'h1', text: 'The Champions'
    end
  end

  test 'non-coach cannot edit team' do
    before_tournament do
      sign_in_as :pele

      navigate_to 'Teams'
      click_on 'Campeones'

      assert_selector 'a', text: 'Edit', count: 0
    end
  end

  test 'member can NOT leave global team' do
    before_tournament do
      sign_in_as :diego

      navigate_to 'Teams'
      click_on 'Global'

      assert_selector 'a', text: 'Leave team', count: 0
    end
  end

  test 'coach can NOT leave the team' do
    before_tournament do
      sign_in_as :diego

      navigate_to 'Teams'
      click_on 'Campeones'

      assert_selector 'a', text: 'Leave team', count: 0
    end
  end

  test 'non-coach can leave the team' do
    before_tournament do
      sign_in_as :pele

      navigate_to 'Teams'
      click_on 'Campeones'
      click_on 'Leave team'

      assert_selector '.flash-messages', text: 'You left the team.'
      assert_selector 'h1', text: 'your dashboard'
    end
  end

  test 'refresh invitation token' do
    before_tournament do
      using_browser do
        sign_in_as :diego

        navigate_to 'Teams'
        click_on 'Campeones'

        within('section#admin') do
          assert_changes -> { find_field('Invitation link').value } do
            click_on 'Refresh invitation link'
          end
        end
      end
    end
  end
end
