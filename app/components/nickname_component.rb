class NicknameComponent < ViewComponent::Base
  def initialize(user:, open_form: false)
    @user = user
    @open_form = open_form
  end

  def nickname
    @user.nickname
  end

  def open_form?
    @open_form
  end

  def show_form?
    open_form? || errors?
  end

  def errors?
    @user.errors.any?
  end

  def errors
    @user.errors&.to_a
  end
end
