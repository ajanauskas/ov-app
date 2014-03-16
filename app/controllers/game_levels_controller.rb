class GameLevelsController < ApplicationController
  before_filter :check_authentication

  def index
    @game_levels = game.levels
  end

  def new
    @game_level = game.levels.build(sort: suggested_sort)
  end

  def create
  end

  def edit
    @game_level = game.levels.find(params[:id])
  end

  def update
    @game_level = game.levels.find(params[:id])
  end

  private

  def game
    @game ||= @current_user.games.find(params[:game_id])
  end

  def suggested_sort
    @game.levels.last.try(:sort) || 1
  end

  def game_level_params
    if params[:game_level]
      params.require(:game_level).permit(:sort, :description)
    end
  end
end
