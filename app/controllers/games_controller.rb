class GamesController < ApplicationController
  def index
    @games = Game.active.order(start: :asc)
  end
end
