require 'test_helper'

class TeamRankingServiceTest < ActiveSupport::TestCase
  test '.call!' do
    membership_1, membership_2 = memberships(:diego_campeones, :pele_campeones)
    membership_1.update_column(:ranking_position, nil)
    membership_2.update_column(:ranking_position, nil)

    assert_changes -> { membership_2.reload.ranking_position }, to: 2 do
      assert_changes -> { membership_1.reload.ranking_position }, to: 1 do
        TeamRankingService.new.call!
      end
    end
  end
end
