class ApplicationReflex < StimulusReflex::Reflex
  delegate :current_user, to: :connection
  around_reflex :switch_locale

  private

  def switch_locale(&action)
    locale = current_user.try(:locale) || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
