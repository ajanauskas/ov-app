class GamesController < ApplicationController
  before_filter :check_authentication, except: [:index]

  def index
    @games = Game.active.order(start: :asc)
  end

  def my
    @games = @current_user.games
  end

  def new
    @game = Game.new
  end

  def edit
    @game = @current_user.games.find(params[:id])
  end

  def update
    @game = @current_user.games.find(params[:id])

    if @game.update(game_params)
      redirect_to edit_game_path(@game)
    else
      render :edit
    end
  end

  def create
    @game = Game.new(game_params)

    if Game.create_with_game_owner(@game, @current_user)
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
