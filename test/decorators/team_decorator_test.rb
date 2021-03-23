require 'test_helper'

class TeamDecoratorTest < ActiveSupport::TestCase
  test '#invitation_link' do
    assert_equal 'http://tippkick.test/teams/tkid_campeones/join/campeones_token',
                 teams(:campeones).decorate.invitation_link
  end
end
