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
end
