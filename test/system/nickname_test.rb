require 'application_system_test_case'

class NicknameTest < ApplicationSystemTestCase
  test 'change nickname' do
    before_tournament do
      using_browser do
        sign_in_as :diego

        within('#nickname-component') do
          assert_text 'digi'
          click_on 'Change Nickname'

          fill_in 'nickname', with: '', wait: 0.5
          click_on 'Save'

          assert_selector '.errors', text: "Nickname can't be blank"

          fill_in 'nickname', with: 'pele'
          click_on 'Save'

          assert_selector '.errors', text: 'Nickname has already been taken'

          fill_in 'nickname', with: 'Diego'
          click_on 'Save'

          assert_text 'Diego'
        end
      end
    end
  end
end
