require 'test_helper'

class NavigationComponentTest < ViewComponent::TestCase
  test '.render, not signed_in' do
    skip # link_to with url_for (or just params) does not work
    # DRb::DRbRemoteError: No route matches {:locale=>:"de-CH"} (ActionController::UrlGenerationError)

    component = NavigationComponent.new(signed_in: false)
    render_inline component
    assert_link 'Sign in'
    assert_no_link 'Dashboard'
    assert_no_link 'Tournament'
    assert_no_link 'Profile'
  end

  test '.render, signed_in' do
    component = NavigationComponent.new(signed_in: true)
    render_inline component
    assert_no_link 'Sign In'
    assert_link 'Dashboard'
    assert_link 'Tournament'
    assert_link 'Profile'
  end

  test '.render, signed_in before tournament' do
    before_tournament do
      render_inline NavigationComponent.new(signed_in: true)
      assert_link 'Tournament', href: '/tournament/bets'
    end
  end

  test '.render, signed_in during tournament' do
    before_game_25 do
      render_inline NavigationComponent.new(signed_in: true)
      assert_link 'Tournament', href: '/tournament/games'
    end
  end

  test '.render, signed_in after tournament' do
    after_tournament do
      render_inline NavigationComponent.new(signed_in: true)
      assert_link 'Tournament', href: '/tournament/games'
    end
  end
end
