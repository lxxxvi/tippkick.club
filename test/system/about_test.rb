require 'application_system_test_case'

class AboutGamesTest < ApplicationSystemTestCase
  test 'visit about page' do
    visit root_path

    within('nav') do
      assert_link 'About', href: '/about'
    end

    assert_link 'Read more', href: '/about'

    click_on 'Read more'

    assert_selector 'h1', text: 'About'
    assert_link 'Start', href: '/'

    assert_selector 'h2', text: 'What does free mean?'
    assert_selector 'h2', text: 'What about privacy?'
    assert_selector 'h2', text: 'What about "learn by doing"?'
    assert_selector 'h2', text: 'Who are "the creators"?'
    assert_selector 'h2', text: 'Get in touch'

    assert_link 'Tell us!'
  end
end
