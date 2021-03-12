require 'test_helper'
require 'capybara/rails'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :rack_test

  def using_browser(&block)
    Capybara.using_driver(:selenium_headless, &block)
  end

  def sign_in_as(fixture_key, password = :abc)
    user = users(fixture_key)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: password
    click_on 'Log in'
    assert_selector '.flash-messages', text: 'Signed in successfully.'
  end

  def navigate_to(page_name)
    within('nav') do
      click_on page_name
    end
  end
end
