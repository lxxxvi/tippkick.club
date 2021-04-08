class ProfilesController < ApplicationController
  def show
    @form = ProfileForm.new(current_user, redirect_to_path)
  end

  def update
    @form = ProfileForm.new(current_user, redirect_to_path, profile_params)

    if @form.save
      flash[:notice] = t('.success', locale: @form.locale)
      redirect_to(@form.redirect_to_path || dashboard_path)
    else
      flash[:alert] = t('.failure')
      render :show
    end
  end

  private

  def redirect_to_path
    params.dig(:profile, :redirect_to_path) || params[:redirect_to_path]
  end

  def profile_params
    params.require(:profile).permit(:nickname, :rooting_for_team, :redirect_to_path, :locale)
  end
end
