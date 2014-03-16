require 'spec_helper'

describe GamesController do
  before do
    session[:user_id] = current_user
  end

  let(:current_user) { FactoryGirl.create(:user) }

  describe '#new' do
    subject { get :new }
    it { should be_success }
  end

  describe '#create' do
    let(:params) { { game: game_params } }
    let(:game_params) { { } }

    subject { post :create, params }

    context 'game params empty' do
      it "renders conflict, doesn't create new game" do
        expect {
          subject
        }.to_not change {
          Game.count + GameOwner.count
        }

        expect(subject.code).to eq '409'
      end
    end

    context 'valid game params' do
      let(:game_params) do
        {
          start: 1.day.from_now,
          title: 'Awesome game',
          description: 'Be sure to participate'
        }
      end

      let(:last_game) { Game.last }
      let(:last_game_owner) { GameOwner.last }

      it 'creates game' do
        expect {
          subject
        }.to change {
          Game.count
        }.by(1)

        expect(last_game.description).to eq game_params[:description]
        expect(last_game.title).to eq game_params[:title]
        expect(last_game.start.to_i).to eq game_params[:start].to_i
      end

      it 'creates game owner' do
        expect {
          subject
        }.to change {
          GameOwner.count
        }.by(1)

        expect(last_game_owner.user_id).to eq current_user.id
        expect(last_game_owner.game_id).to eq last_game.id
      end
    end
  end
end
