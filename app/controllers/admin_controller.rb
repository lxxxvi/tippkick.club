class AdminController < ApplicationController
  before_action :admin_only

  private

  def admin_only
    authorize! current_user, to: :admin?
  end
end
