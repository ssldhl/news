require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validations' do
    it 'should have valid factory' do
      user = build :user
      expect(user).to be_valid
    end

    it 'should validate presence of attributes' do
      user = build :user, login: nil, provider: nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:login]).to include("can't be blank")
      expect(user.errors.messages[:provider]).to include("can't be blank")
    end

    it 'should validate related entity' do
      user = build :user
      expect(user.build_access_token).to be_valid
    end

    it 'should validate uniqueness of login' do
      user = create :user
      new_user = build :user, login: user.login
      expect(new_user).not_to be_valid

      new_user.login = 'newLogin'
      expect(new_user).to be_valid
    end
  end

  describe '#create_access_token' do
    it 'should save the access token' do
      user = create :user
      expect { user.create_access_token }.to change { AccessToken.count }.by(1)
    end
  end
end
