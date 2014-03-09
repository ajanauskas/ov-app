require 'spec_helper'

describe UsersController do
  describe '#new' do
    subject { get :new }
    it { should be_success }
  end

  describe '#create' do
    subject { post :create, params }

    let(:params) { { user: user_params } }

    context 'invalid data' do
      let(:user_params) { { } }
      its(:code) { should eq '409' }
    end

    context "passwords don't match" do
      let(:user_params) do
        {
          login: 'abrakadabra',
          password: 'hello123',
          password_confirmation: 'hello12',
          email: 'test@test.com'
        }
      end
      its(:code) { should eq '409' }
    end

    context 'valid params' do
      let(:user_params) do
        {
          login: 'abrakadabra',
          password: 'hello123',
          password_confirmation: 'hello123',
          email: 'test@test.com'
        }
      end
      it { should be_redirect }

      it 'creates user' do
        expect {
          subject
        }.to change {
          User.count
        }.by(1)
      end
    end
  end

  describe '#login_form' do
    subject { get :login_form }
    it { should be_success }
  end

  describe '#login' do
    subject { put :login, params }
    let(:params) { { login: login_params } }
    let!(:user) { FactoryGirl.create(:user, login: 'testuser', password: 'labuka') }

    shared_examples 'failed login' do
      its(:code) { should eq '409' }
      it 'leaves session empty' do
        expect {
          subject
        }.to_not change {
          session[:user_id]
        }
      end
    end

    context 'wrong login' do
      let(:login_params) { { login: 'tesuser', password: 'labuka' } }
      it_behaves_like 'failed login'
    end

    context 'wrong password' do
      let(:login_params) { { login: 'testuser', password: 'labas' } }
      it_behaves_like 'failed login'
    end

    context 'correct login' do
      let(:login_params) { { login: 'testuser', password: 'labuka' } }
      it { should be_redirect }
      it 'enters user id inside session' do
        expect {
          subject
        }.to change {
          session[:user_id]
        }.from(nil).to(user.id)
      end
    end
  end
end
