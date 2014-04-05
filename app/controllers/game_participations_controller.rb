class GameParticipationsController < ApplicationController
  before_filter :check_authentication
  before_filter :create_team_and_team_participation

  def show
  end

  def update
  end

  private

  def create_team_and_team_participation
    unless @current_user.team
      Team.dummy_team_for(@current_user)
      @current_user.reload
    end
  end
end
