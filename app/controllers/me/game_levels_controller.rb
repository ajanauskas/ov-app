class Me::GameLevelsController < ApplicationController
  before_filter :check_authentication

  def index
    @game_levels = game.levels
  end

  def new
    @game_level = game.levels.build(sort: suggested_sort)
  end

  def create
    @game_level = game.levels.build

    create_record(@game_level, game_level_params,
      redirect: Proc.new { |record| edit_my_game_level_path(id: record.id, game_id: game.id) })
  end

  def edit
    @game_level = find_game_level
  end

  def update
    @game_level = find_game_level

    update_record(@game_level, game_level_params, redirect: path_to_edit_level)
  end

  def destroy
    @game_level = find_game_level
    @game_level.destroy

    redirect_to my_game_levels_path(id: game.id)
  end

  private

  def path_to_edit_level
    edit_my_game_level_path(id: @game_level.id, game_id: game.id)
  end

  def game
    @game ||= @current_user.games.find(params[:game_id])
  end

  def game_level
    @game_level ||= find_game_level
  end

  def find_game_level
    game.levels.find(params[:id])
  end

  def suggested_sort
    (@game.levels.last.try(:sort) || 0) + 1
  end

  def game_level_params
    if params[:game_level]
      params
        .require(:game_level)
        .permit(:sort, :title, :description, :code)
    end
  end
end
