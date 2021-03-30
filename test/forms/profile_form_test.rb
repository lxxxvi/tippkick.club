require 'test_helper'

class ProfileFormTest < ActiveSupport::TestCase
  test '.save' do
    user = users(:diego)
    form = ProfileForm.new(user, { nickname: 'Maradona', rooting_for_team: 'AUT' })

    assert form.save
    user.reload

    assert_equal 'Maradona', user.nickname
    assert_equal 'AUT', user.rooting_for_team
  end

  test '.save, errors' do
    user = users(:diego)

    form = ProfileForm.new(user, { nickname: 'pele' })
    assert_not form.save
    assert_includes form.errors.to_a, 'Nickname has already been taken'

    form = ProfileForm.new(user, { nickname: '' })
    assert_not form.save
    assert_includes form.errors.to_a, "Nickname can't be blank"
  end
end
