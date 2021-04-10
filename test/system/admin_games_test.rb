require 'application_system_test_case'

class AdminGamesTest < ApplicationSystemTestCase
  include ActionView::RecordIdentifier

  test 'sees admin games' do
    sign_in_as_admin :diego
    navigate_to 'Admin'
    assert_selector 'h1', text: 'Games'
  end

  test 'admin final whistle' do
    game = games(:game_25)

    in_game_25 do
      sign_in_as_admin :diego
      navigate_to 'Admin'

      within("##{dom_id(game)}") do
        assert_selector '.live', text: 'Live'
        click_link
      end

      select '4', from: 'Home team score'
      select '2', from: 'Guest team score'
      check 'Final whistle'
      click_on 'Update Game'

      assert_selector '.flash-messages', text: 'Game successfully updated.'

      within("##{dom_id(game)}") do
        assert_selector '.final-score', text: '(4:2)'
        click_link
      end
    end
  end

  test 'undo final whistle' do
    game = games(:game_25)

    in_game_25 do
      game.final_whistle

      sign_in_as_admin :diego
      navigate_to 'Admin'

      within("##{dom_id(game)}") do
        assert_selector '.final-score', text: '(1:2)'
        click_link
      end

      uncheck 'Final whistle'
      click_on 'Update Game'

      within("##{dom_id(game)}") do
        assert_selector '.live', text: 'Live'
      end
    end
  end
end
