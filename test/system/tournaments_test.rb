require 'application_system_test_case'

class TournamentsTest < ApplicationSystemTestCase
  setup do
    @tournament = tournaments(:uefa_euro_2021)
  end

  test 'visiting the index' do
    visit tournaments_path
    assert_selector 'h1', text: 'Listing tournaments'
  end

  test 'creating a Tournament' do
    visit tournaments_path
    click_on 'New Tournament'

    fill_in 'Name', with: 'UEFA Euro 2024'
    click_on 'Create Tournament'

    assert_text 'Listing tournaments'
  end

  test 'updating a Tournament' do
    visit tournaments_path
    click_on 'Edit', match: :first

    fill_in 'Name', with: @tournament.name
    click_on 'Update Tournament'

    assert_text 'Tournament was successfully updated'
  end

  test 'destroying a Tournament' do
    visit tournaments_path

    click_on 'Destroy', match: :first

    assert_text 'Tournament was successfully destroyed'
  end
end
