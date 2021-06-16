require 'test_helper'

class TeamMembershipsComponentTest < ViewComponent::TestCase
  test '.render' do
    component = TeamMembershipsComponent.new(team: teams(:global), params: {}, user: users(:diego))
    render_inline(component)
    assert_selector 'nav.pagination', count: 0
    assert_selector '.team-memberships'
  end

  test '.render with pagination' do
    default_items = Pagy::VARS[:items]
    Pagy::VARS[:items] = 2
    component = TeamMembershipsComponent.new(team: teams(:global), params: {}, user: users(:diego))
    render_inline(component)
    assert_selector 'nav.pagination', count: 1
  ensure
    Pagy::VARS[:items] = default_items
  end

  test '.render, columns before tournament' do
    before_tournament do
      component = TeamMembershipsComponent.new(team: teams(:global), params: {}, user: users(:diego))
      render_inline(component)
      assert_selector '.table-header', count: 1
    end
  end

  test '.render, different elements before and after tournament starts' do
    before_tournament do
      component = TeamMembershipsComponent.new(team: teams(:campeones), params: {}, user: users(:diego))
      render_inline(component)
      assert_table_header_columns count: 1
      assert_user_total_points_history_navigation count: 0
    end

    in_game_1 do
      component = TeamMembershipsComponent.new(team: teams(:campeones), params: {}, user: users(:diego))
      render_inline(component)
      assert_table_header_columns count: 3
      assert_user_total_points_history_navigation
    end
  end

  test '.render, does not show user total points in global team' do
    in_game_1 do
      component = TeamMembershipsComponent.new(team: teams(:global), params: {}, user: users(:diego))
      render_inline(component)
      assert_user_total_points_history_navigation count: 0
    end
  end

  private

  def assert_table_header_columns(options = {})
    assert_selector '.table-header > *', options
  end

  def assert_user_total_points_history_navigation(options = {})
    assert_selector '.table-body .user-total-points-history-navigation', options
  end
end
