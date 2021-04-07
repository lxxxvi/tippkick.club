require 'test_helper'

class UserDecoratorTest < ActiveSupport::TestCase
  test '#nickname_with_team_emoji' do
    assert_equal 'pele 🇵🇹', users(:pele).decorate.nickname_with_team_emoji
  end

  test '#rooting_for_team_as_emoji' do
    assert_equal '🇵🇹', users(:pele).decorate.rooting_for_team_as_emoji
  end
end
