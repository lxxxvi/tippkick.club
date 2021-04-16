class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  around_action :switch_locale

  private

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_path
  end

  def switch_locale(&action)
    locale = find_locale || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def find_locale
    locale_from_current_user || locale_from_session
  end

  def locale_from_current_user
    current_user.try(:locale)
  end

  def locale_from_session
    set_session_locale if params[:locale].present?
    session[:locale]
  end

  def set_session_locale
    return unless I18n.locale_available?(params[:locale].to_sym)

    session[:locale] = params[:locale].to_sym
  end
end
