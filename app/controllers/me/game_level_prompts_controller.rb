class Me::GameLevelPromptsController < ApplicationController
  before_filter :check_authentication

  def new
    @game_level_prompt = game_level.prompts.build
  end

  def create
    @game_level_prompt = game_level.prompts.build

    create_record(@game_level_prompt, game_level_prompt_params, redirect: path_to_edit_level)
  end

  def edit
    @game_level_prompt = find_game_level_prompt
  end

  def update
    @game_level_prompt = find_game_level_prompt

    update_record(@game_level_prompt, game_level_prompt_params, redirect: path_to_edit_level)
  end

  def destroy
    @game_level_prompt = find_game_level_prompt
    @game_level_prompt.destroy

    reditect_to edit_my_game_level_path(game_id: game.id, id: game_level.id)
  end

  private

  def path_to_edit_level
    edit_my_game_level_path(id: game_level.id, game_id: game.id)
  end

  def game
    @game ||= @current_user.games.find(params[:game_id])
  end

  def game_level
    @game_level ||= game.levels.find(params[:level_id])
  end

  def find_game_level_prompt
    game_level.prompts.find(params[:id])
  end

  def game_level_prompt_params
    if params[:game_level_prompt]
      params
        .require(:game_level_prompt)
        .permit(:appears_in, :description)
    end
  end
end
