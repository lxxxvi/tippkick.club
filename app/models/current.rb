class Current < ActiveSupport::CurrentAttributes
  attribute :user

  # TODO: fixme
  def user
    @user ||= User.find_by(email: 'diego@tippkick.test')
  end
end
