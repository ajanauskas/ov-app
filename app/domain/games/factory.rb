module Games
  class Factory
    attr_reader :user, :params, :game

    def initialize(user, params)
      @user = user
      @params = params
    end

    def create
      @game = Game.new(params)

      ActiveRecord::Base.transaction do
        @game.save!
        @game_owner = GameOwner.new
        @game_owner.user_id = user.id
        @game_owner.game_id = @game.id
        @game_owner.save!
      end

      true
    rescue ActiveRecord::RecordInvalid
      false
    end
  end
end
