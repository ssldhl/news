require 'rails_helper'

RSpec.describe AccessToken, type: :model do
  describe '#validations' do
    it 'should have valid factory' do
      expect(build(:access_token)).to be_valid
    end

    it 'should validate presence of token' do
      access_token = build :access_token, token: ''
      expect(access_token).not_to be_valid
      expect(access_token.errors.messages[:token]).to include("can't be blank")
    end

    it 'should validate uniqueness of token' do
      access_token = create :access_token
      new_access_token = build :access_token, token: access_token.token
      expect(new_access_token).not_to be_valid
      expect(new_access_token.errors.messages[:token]).to include("has already been taken")

      new_access_token.token = 'newToken'
      expect(new_access_token).to be_valid
    end
  end

  describe '#new' do
    it 'should have token present after initialize' do
      expect(subject.token).to be_present
    end

    it 'should generate unique token' do
      access_token = subject
      new_access_token = AccessToken.new
      expect(new_access_token.token).not_to eq(access_token.token)
    end

    it 'should generate token once' do
      user = create :user
      access_token = user.create_access_token
      expect(access_token.token).to eq(access_token.reload.token)
    end
  end
end
