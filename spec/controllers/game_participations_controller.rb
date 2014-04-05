require 'spec_helper'

describe GameParticipationsController do
  describe '#show' do
    let(:current_user) { FactoryGirl.create(:user) }

    before do
      session[:user_id] = current_user.id
    end

    subject(:show) { get :show }

    it 'creates dummy team for user and confirms team game participation' do
    end
  end
end
