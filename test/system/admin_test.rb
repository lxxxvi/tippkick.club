require 'application_system_test_case'

class AdminTest < ApplicationSystemTestCase
  test 'admin sees Admin in main navigation' do
    sign_in_as_admin :diego
    within 'nav' do
      assert_link 'Admin', href: '/admin/games'
    end
  end

  test 'non-admin does not see Admin in main navigation' do
    sign_in_as :diego
    within 'nav' do
      assert_no_link 'Admin'
    end
  end
end
