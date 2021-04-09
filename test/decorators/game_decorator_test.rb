require 'test_helper'

class GameDecoratorTest < ActiveSupport::TestCase
  test '#display_uefa_game_id' do
    assert_equal 'Match 25', games(:game_25).decorate.display_uefa_game_id
  end

  test '#display_kickoff_at_from_now' do
    before_game_25 do
      assert_equal '5 minutes', games(:game_25).decorate.display_kickoff_at_from_now
    end
  end

  test '#display_venue' do
    assert_equal 'Baku', games(:game_25).decorate.display_venue
  end

  test '#display_team_name' do
    assert_equal 'Switzerland', games(:game_25).decorate.display_home_team_name
    assert_equal 'Turkey', games(:game_25).decorate.display_guest_team_name
  end

  test '#display_tournament_phase' do
    assert_equal 'Group phase', games(:game_25).decorate.display_tournament_phase
  end

  test '#display_teams_short' do
    assert_equal 'SUI - TUR', games(:game_25).decorate.display_teams_short
  end

  test '#display_scores_short' do
    assert_equal '1:2', games(:game_25).decorate.display_scores_short
  end

  test '.fifa_country_codes_as_options' do
    assert_equal ['Austria', :AUT], GameDecorator.fifa_country_codes_as_options.first
    assert_equal ['Wales', :WAL], GameDecorator.fifa_country_codes_as_options.last
  end
end
