class NavigationComponent < ViewComponent::Base
  delegate :admin?, to: :@user

  def initialize(signed_in:, user: nil)
    @signed_in = signed_in
    @user = user || User.new
  end

  def signed_in?
    @signed_in
  end

  def bets_or_games_path
    return bets_path if Tournament.before_first_kickoff?

    games_path
  end

  def other_locale_key
    other_locale.keys.first
  end

  def other_locale_abbreviation
    other_locale.values.first
  end

  private

  def other_locale
    @other_locale ||= I18n.available_locales_abbrevations.except(I18n.locale)
  end
end
