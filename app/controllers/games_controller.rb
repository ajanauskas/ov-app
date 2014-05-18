class GamesController < ApplicationController
  def index
    @games = Game.active.order(start: :asc)
  end

  def statistics
    @game = Game.includes(:levels).find(params[:game_id])

    @teams_participated = GameLevelCompletion
      .where(game_level_id: @game.levels.map(&:id))
      .uniq(:team_id)
      .includes(:team)
      .map(&:team)
    @game_levels = @game.levels
    @game_level_completions = GameLevelCompletion.where(game_level_id: @game_levels.map(&:id))

    @team_completion_time = {}
    @teams_participated.each do |team|
      time = 0
      level_completion = {}
      @game_level_completions.each do |completion|
        next if completion.team_id != team.id
        time += completion.completed_in
        level_completion[completion.game_level_id] = completion.completed_in
      end

      @team_completion_time[team.id] = {}
      @team_completion_time[team.id][:time] = time
      @team_completion_time[team.id][:levels] = level_completion
    end
  end
end
