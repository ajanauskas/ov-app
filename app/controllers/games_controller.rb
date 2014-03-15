class GamesController < ApplicationController
  before_filter :check_authentication

  def new
    @game = Game.new
  end
end
