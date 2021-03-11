require 'test_helper'

class GameDecoratorTest < ActiveSupport::TestCase
  test '.flag_path' do
    game = games(:game_25)
    assert_equal '/images/flags/sui.svg', GameDecorator.flag_path(game.home_team_name)
  end

  test '#display_uefa_game_id' do
    assert_equal 'Match 25', games(:game_25).decorate.display_uefa_game_id
  end

  test '#display_kickoff_at_from_now' do
    travel_to '2021-06-20 15:12:00 UTC' do
      assert_equal 'about 1 hour', games(:game_25).decorate.display_kickoff_at_from_now
    end
  end

  test '#display_venue' do
    assert_equal 'Baku', games(:game_25).decorate.display_venue
  end

  test '#display_team_name' do
    assert_equal 'Switzerland', games(:game_25).decorate.display_home_team_name
    assert_equal 'Turkey', games(:game_25).decorate.display_guest_team_name
  end
end
