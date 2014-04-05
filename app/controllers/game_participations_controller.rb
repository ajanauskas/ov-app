class GameParticipationsController < ApplicationController
  before_filter :check_authentication
  before_filter :create_team_and_team_participation

  def show
  end

  def update
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
