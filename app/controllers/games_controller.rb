class GamesController < ApplicationController
  before_filter :check_authentication

  def new
    @game = Game.new
  end

  def create
    factory = Games::Factory.new(@current_user, game_params)
    created = factory.create
    @game = factory.game

    if created
      redirect_to root_path
    else
      render :new, status: :conflict
    end
  end

  private

  def game_params
    if params[:game].present?
      params.require(:game).permit(:title, :description, :start, :active)
    end
  end
end
