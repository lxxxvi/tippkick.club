require 'application_system_test_case'

class LandingPageGamesTest < ApplicationSystemTestCase
  test 'visit landig page' do
    visit root_path

    assert_selector 'html' do |html_element|
      assert_equal 'en', html_element['lang']
    end

    assert_selector('meta[name=description]', visible: false) do |meta_element|
      assert_equal 'Free online betting game for UEFA Euro 2020.', meta_element['content']
    end

    assert_selector 'h1', text: "Let's go!"
    assert_link 'Sign up for free!', href: '/users/sign_up'
    assert_selector 'h2', text: 'Why join?'
    assert_selector 'h2', text: 'Rules'
  end

  test 'changes the language on the landing page' do
    visit root_path

    within('nav') do
      click_on 'DE'
    end

    assert_selector 'html' do |html_element|
      assert_equal 'de', html_element['lang']
    end

    assert_selector('meta[name=description]', visible: false) do |meta_element|
      assert_equal 'Gratis online Tippspiel für die UEFA Euro 2020.', meta_element['content']
    end

    assert_selector 'h1', text: "Los geht's!"
    assert_link 'Gratis registrieren!', href: '/users/sign_up'
    assert_selector 'h2', text: 'Warum teilnehmen?'
    assert_selector 'h2', text: 'Regeln'

    click_on 'Mehr darüber'

    assert_selector 'h1', text: 'Über'
  end

  test 'redirects home page when clicking logo icon' do
    visit about_path

    click_on find('svg.icon-tabler-ball-football').text

    assert_selector 'h1', text: "Let's go!"
  end
end
