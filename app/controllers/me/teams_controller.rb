class Me::TeamsController < ApplicationController
  before_filter :check_authentication

  def index
    @teams = @current_user.teams.includes(:members, team_invitations: :user).all
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.owner = @current_user
    create_record(@team, team_params, redirect: teams_path)
  end

  def edit
    @team = @current_user.teams.find(params[:id])
  end

  def update
    @team = @current_user.teams.find(params[:id])

    update_record(@team, team_params, redirect: edit_my_team_path(@team))
  end

  def destroy
    @team = @current_user.teams.find(params[:id])
    @team.destroy
    redirect_to user_path(@current_user)
  end

  private

  def team_params
    if params[:team]
      params.require(:team).permit(:name)
    end
  end
end
