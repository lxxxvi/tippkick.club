class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  around_action :switch_locale

  private

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_path
  end

  def switch_locale(&action)
    locale = current_user.try(:locale) || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
