class TeamsController < ApplicationController
  before_action :set_team, only: %i[show]

  def show; end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new_with_user(current_user, team_params)

    if @team.save
      flash[:notice] = t('.successfully_created_team')
      redirect_to @team
    else
      render :new
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

  def set_team
    @team = Team.find_by!(tippkick_id: params[:id])
  end
end
