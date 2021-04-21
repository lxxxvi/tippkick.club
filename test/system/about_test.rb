require 'application_system_test_case'

class AboutGamesTest < ApplicationSystemTestCase
  test 'visit about page' do
    visit root_path

    within('nav') do
      assert_link 'About', href: '/about'
    end

    click_on 'More about the app'

    assert_selector 'h1', text: 'About'
    assert_link 'Start', href: '/'

    assert_selector 'h2', text: 'What does free mean?'
    assert_selector 'h2', text: 'What happens to my data?'
    assert_selector 'h2', text: 'Web technologies?'
    assert_selector 'h2', text: 'Who are we?'
    assert_selector 'h2', text: 'Get in touch'

    assert_link 'Tell us!'
  end
end
