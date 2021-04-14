require 'application_system_test_case'

class LandingPageGamesTest < ApplicationSystemTestCase
  test 'visit landig page' do
    visit root_path
    assert_selector 'h1', text: 'We are back!'
    assert_link 'Sign up now!', href: '/users/sign_up'
    assert_selector 'h2', text: 'Why join?'
  end

  test 'changes the language on the landing page' do
    visit root_path

    click_on 'Deutsch'
    assert_selector 'h1', text: 'Wir sind zurück!'
    assert_link 'Jetzt registrieren!', href: '/users/sign_up'
    assert_selector 'h2', text: 'Warum mitmachen?'

    click_on 'Mehr dazu'

    assert_selector 'h1', text: 'Über'
  end
end
