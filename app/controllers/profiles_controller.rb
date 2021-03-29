class ProfilesController < ApplicationController
  def show
    @form = ProfileForm.new(current_user)
  end

  def update
    @form = ProfileForm.new(current_user, profile_params)

    if @form.save
      flash[:notice] = t('.success')
      redirect_to profile_path
    else
      flash[:alert] = t('.failure')
      render :show
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:nickname)
  end
end
