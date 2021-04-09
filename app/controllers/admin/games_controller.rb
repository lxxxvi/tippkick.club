class Admin::GamesController < AdminController
  before_action :set_game, only: %i[edit update]

  def index
    @games = Game.ordered_chronologically
  end

  def edit; end

  def update
    @game.assign_attributes(game_params.except(:final_whistle_at))
    if @game.final_whistle(reset: reset_final_whistle?)
      flash[:notice] = t('.success')
      redirect_to admin_games_path
    else
      flash[:alert] = t('.failure')
      render :edit
    end
  end

  private

  def game_params
    params.require(:game).permit(:home_team_name, :guest_team_name,
                                 :home_team_score, :guest_team_score,
                                 :final_whistle_at)
  end

  def reset_final_whistle?
    game_params[:final_whistle_at].to_i.zero?
  end

  def set_game
    @game = Game.find(params[:id])
  end
end
