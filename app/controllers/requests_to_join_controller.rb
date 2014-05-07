class RequestsToJoinController < ApplicationController
  before_filter :check_authentication
  before_filter :check_authorization, only: [:update, :destroy]

  def create
    @team = team

    if @current_user.team_invitations.where(team_id: @team.id).exists?
      flash[:error] = t('.request_already_sent')
      return redirect_to teams_path
    elsif @current_user.teams.where(id: @team.id).exists?
      flash[:error] = t('.already_in_team')
      return redirect_to teams_path
    end

    @team.request_to_join!(@current_user)
    flash[:notice] = t('.request_sent')
    redirect_to my_teams_path
  end

  def update
    @invitation = team.team_invitations.requests_to_join.find(params[:id])
    @invitation.approve
    redirect_to my_teams_path
  end

  def destroy
    @invitation = team.team_invitations.requests_to_join.find(params[:id])
    @invitation.reject
    redirect_to my_teams_path
  end

  private

  def check_authorization
    if @current_user.id != team.owner_id
      flash[:error] = 'Access forbidden'
      redirect_to root_path
    end
  end

  def team
    @team ||= Team.find(params[:team_id])
  end
end
