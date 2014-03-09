class GamesController < ApplicationController
  before_filter :check_authentication
end
