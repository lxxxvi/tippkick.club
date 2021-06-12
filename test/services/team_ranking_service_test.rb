require 'test_helper'

class TeamRankingServiceTest < ActiveSupport::TestCase
  test '.call!' do
    Membership.update_all(ranking_position: nil)
    TeamRankingService.new.call!

    # campeones
    assert_equal 1, memberships(:diego_campeones).ranking_position
    assert_equal 2, memberships(:pele_campeones).ranking_position

    # global
    assert_equal 1, memberships(:diego_global).ranking_position
    assert_equal 2, memberships(:zinedine_global).ranking_position
    assert_equal 3, memberships(:pele_global).ranking_position
  end

  test '.call! with single team_id' do
    campeones_team = teams(:campeones)
    campeones_team.memberships.update_all(ranking_position: nil)

    diego_global = memberships(:diego_global)
    diego_global.update_column(:ranking_position, 999)
    diego_campeones = memberships(:diego_campeones)

    assert_no_changes -> { diego_global.reload.ranking_position },
                      'Ranking position for other than campeones team membership should NOT change' do
      assert_changes -> { diego_campeones.reload.ranking_position },
                     'Ranking position in campeones team membership should change',
                     to: 1 do
        TeamRankingService.new(team_ids: campeones_team.id).call!
      end
    end
  end
end
