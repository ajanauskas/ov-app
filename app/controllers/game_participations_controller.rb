class GameParticipationsController < ApplicationController
  before_filter :check_authentication
  before_filter :create_team_and_team_participation

  def show
    @game_level_code = GameLevelCode.new
  end

  def update
    @game_level_code = GameLevelCode.new
    @game_level_code.game_participation = @participation
    @game_level_code.code = params[:game_level_code][:code]

    if @game_level_code.valid?
      if !@participation.can_advance_level?
        @participation.destroy
        return redirect_to root_path
      end

      @participation.advance_level!
      @game_level_code.code = nil
    end

    render :show
  end

  private

  def create_team_and_team_participation
    Team.create_dummy_team_for(@current_user)

    @participation = TeamGameParticipation
      .create_participation_for(
        user: @current_user,
        game: game
      )
  end

  def game
    @game ||= Game.find(params[:game_id])
  end
end
