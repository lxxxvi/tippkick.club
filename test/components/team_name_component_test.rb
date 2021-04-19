require 'test_helper'

class TeamNameComponentTest < ViewComponent::TestCase
  test '#render, global team' do
    render_inline(TeamNameComponent.new(team: teams(:global)))
    assert_selector 'svg'
  end

  test '#render, other than global team' do
    render_inline(TeamNameComponent.new(team: teams(:campeones)))
    assert_selector 'svg', count: '0'
  end
end
