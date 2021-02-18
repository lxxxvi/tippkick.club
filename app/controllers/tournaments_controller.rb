class TournamentsController < ApplicationController
  before_action :set_tournament, only: %i[show edit update destroy]

  def index
    @tournaments = Tournament.all
  end

  def show; end

  def new
    @tournament = Tournament.new
  end

  def edit; end

  def create
    @tournament = Tournament.new(tournament_params)

    if @tournament.save
      redirect_to Tournament, notice: 'Tournament was successfully created.'
    else
      render :new
    end
  end

  def update
    if @tournament.update(tournament_params)
      redirect_to Tournament, notice: 'Tournament was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @tournament.destroy
    redirect_to Tournament, notice: 'Tournament was successfully destroyed.'
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:id])
  end

  def tournament_params
    params.require(:tournament).permit(:name)
  end
end
