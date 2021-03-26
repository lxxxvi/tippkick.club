class NicknameReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def open_form
    update_component(open_form: true)
  end

  def close_form
    current_user.reload
    update_component
  end

  def update(value)
    current_user.update(nickname: value)
    update_component
  end

  private

  def update_component(open_form: false)
    morph '#nickname-component', render(NicknameComponent.new(user: current_user, open_form: open_form), layout: false)
  end
end
