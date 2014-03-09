# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    title 'Very nice game'
    description 'Such description'

    after(:create) do |game, evaluator|
      owner = evaluator.try(:owner) || create(:user)
      game_owner = create(:game_owner, game: game, owner: owner)
      game.game_owners = [game_owner]
      game.owners = [owner]
    end
  end
end
