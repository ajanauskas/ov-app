class Me::TeamMembersController < ApplicationController
  before_filter :check_authentication

  def update
    team_member = @current_user.team_members.find(params[:id])

    team_member.activate_user!

    redirect_to user_path(@current_user)
  end

  def destroy
    team_member = @current_user.team_members.find(params[:id])

    team_member.destroy!

    redirect_to user_path(@current_user)
  end
end
