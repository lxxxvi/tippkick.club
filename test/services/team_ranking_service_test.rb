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
end
