require 'test_helper'

class TournamentNavigationComponentTest < ViewComponent::TestCase
  test '.render, tournament ongoing' do
    before_game_25 do
      component = TournamentNavigationComponent.new

      render_inline component

      # We cannot test/simulate scenarios for `link_to_unless_current`,
      # since we use a controller that is scoped.
      assert_link 'Predictions', href: '/tournament/predictions'
      assert_link 'Games', href: '/tournament/games'
    end
  end

  test '.render, not render before tournament has started' do
    before_tournament do
      render_inline TournamentNavigationComponent.new
      assert page.text.empty?, 'Should not render before the tournament'
    end
  end

  test '.render, not render after tournament has ended' do
    after_tournament do
      render_inline TournamentNavigationComponent.new
      assert page.text.empty?, 'Should not render after the tournament'
    end
  end
end
