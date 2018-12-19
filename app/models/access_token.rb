class AccessToken < ApplicationRecord
  belongs_to :user
  after_initialize :generate_token

  validates :token, presence: true, uniqueness: true

  private

  def generate_token
    self.token = loop do
      random_token = SecureRandom.hex(10)
      break random_token unless AccessToken.exists?(token: random_token)
    end
  end
end
