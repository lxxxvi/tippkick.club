class Current < ActiveSupport::CurrentAttributes
  attribute :user

  # TODO: fixme
  def user
    User.first
  end
end
