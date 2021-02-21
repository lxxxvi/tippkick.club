require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test 'valid game' do
    game = Game.new(venue: 'Copenhagen', tournament_phase: 'group',
                    home_team_name: 'DEN', guest_team_name: 'FIN',
                    kickoff_at: '2021-06-12 16:00:00')
    assert game.save

    assert_equal 0, game.home_team_score
    assert_equal 0, game.guest_team_score
  end
end
