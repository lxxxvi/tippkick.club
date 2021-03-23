class TeamsController < ApplicationController
  before_action :set_team, only: %i[show edit update destroy]

  def show; end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new_with_user(current_user, team_params)

    if @team.save
      flash[:notice] = t('.success')
      redirect_to @team
    else
      flash[:alert] = t('.failure')
      render :new
    end
  end

  def edit; end

  def update
    authorize! @team

    if @team.update(team_params)
      flash[:notice] = t('.success')
      redirect_to @team
    else
      flash[:alert] = t('.failure')
      render :edit
    end
  end

  def destroy
    authorize! @team

    @team.destroy
    flash[:notice] = t('.success')
    redirect_to dashboard_path
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

  def set_team
    @team = Team.find_by!(tippkick_id: params[:id])
  end
end
