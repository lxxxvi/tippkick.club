class DashboardComponent < ViewComponent::Base
  attr_reader :user

  def initialize(user:)
    @user = user
  end

  def title
    "#{title_greeting}, #{title_dashboard}"
  end

  private

  def title_greeting
    t('dashboard_component.hey_nickname', nickname: user.nickname)
  end

  def title_dashboard
    t('dashboard_component.this_is_your_dashboard')
  end
end
