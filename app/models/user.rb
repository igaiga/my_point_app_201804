class User < ApplicationRecord
  before_validation :set_token, on: :create

  private

  def set_token
    self.token = SecureRandom.uuid
  end
end
