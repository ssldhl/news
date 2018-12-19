require 'rails_helper'

RSpec.describe UserAuthenticator do
  describe '#perform' do
    let(:authenticator) { described_class.new('sample_code') }
    subject { authenticator.perform }

    context 'when the code is incorrect' do
      let(:error) { double('Sawyer::Resource', error: 'bad_verification_code') }

      before do
        allow_any_instance_of(Octokit::Client).to receive(
          :exchange_code_for_token
        ).and_return(error)
      end

      it 'should raise an error' do
        expect { subject }.to raise_error(
          UserAuthenticator::AuthenticationError
        )
        expect(authenticator.user).to be_nil
      end
    end

    context 'when the code is correct' do
      let(:user_data) do
        {
          login: 'jdoe1',
          url: 'http://example.com/john',
          avatar_url: 'http://example.com/avatar/john.png',
          name: 'John Doe'
        }
      end

      before do
        allow_any_instance_of(Octokit::Client).to receive(
          :exchange_code_for_token
        ).and_return('validaccesstoken')

        allow_any_instance_of(Octokit::Client).to receive(
          :user
        ).and_return(user_data)
      end

      it 'should save the user if does not exist' do
        expect { subject }.to change { User.count }.by(1)
        expect(User.last.name).to eq('John Doe')
      end

      it 'should reuse already registered user' do
        user = create :user, user_data
        subject
        expect(authenticator.user.login).to eq(user.login)
        expect(authenticator.user).to be_valid
      end

      it "should create and set user's access token" do
        expect { subject }.to change { AccessToken.count }.by(1)
        expect(authenticator.access_token).to be_present
      end

      it 'should return previous access token if user exists' do
        user = create :user, user_data
        user.create_access_token
        expect { subject }.not_to change { AccessToken.count }.from(1)
        expect(authenticator.access_token).to eq(user.access_token)
      end
    end
  end
end