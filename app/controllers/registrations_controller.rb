class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    profile_path(redirect_to_path: stored_location_for(resource))
  end
end
