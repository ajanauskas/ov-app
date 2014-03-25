class GameLevelsController < ApplicationController
  before_filter :check_authentication

  def index
    @game_levels = game.levels
  end

  def new
    @game_level = game.levels.build(sort: suggested_sort)
  end

  def create
    @game_level = game.levels.build(game_level_params)

    if @game_level.save
      redirect_to game_levels_path
    else
      render :new, status: :conflict
    end
  end

  def edit
    @game_level = find_game_level
  end

  def update
    @game_level = find_game_level
    @game_level.attributes = game_level_params

    if @game_level.save
      redirect_to game_levels_path
    else
      render :edit, status: :conflict
    end
  end

  def destroy
    @game_level = find_game_level
    @game_level.destroy

    redirect_to edit_game_path(game)
  end

  private

  def game
    @game ||= @current_user.games.find(params[:game_id])
  end

  def find_game_level
    game.levels.find(params[:id])
  end

  def suggested_sort
    @game.levels.last.try(:sort) || 1
  end

  def game_level_params
    if params[:game_level]
      params
        .require(:game_level)
        .permit(:sort, :description)
    end
  end
end
