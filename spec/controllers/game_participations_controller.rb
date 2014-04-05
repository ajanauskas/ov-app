require 'spec_helper'

describe GameParticipationsController do
  describe '#show' do
    let(:current_user) { FactoryGirl.create(:user) }
    let(:game) { FactoryGirl.create(:game) }

    before do
      session[:user_id] = current_user.id
    end

    subject(:show) { get :show, game_id: game.id }

    it 'creates dummy team for user' do
      expect {
        show
      }.to change {
        current_user.reload.team
      }.from(nil).to(instance_of(Team))
    end

    it 'creates participation for game' do
      expect {
        show
      }.to change {
        TeamGameParticipation.find_by(user: current_user)
      }.from(nil).to(instance_of(TeamGameParticipation))
    end
  end
end
