class GameLevelCode
  include ActiveModel::Model

  attr_accessor :code, :game_participation

  validate :code, presence: true
  validate :code_is_correct

  private

  def code_is_correct
    if game_participation.current_game_level.code != code
      errors.add(:code, :invalid)
    end
  end
end
