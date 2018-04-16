class User < ApplicationRecord
  has_many :points
  before_validation :set_token, on: :create

  def self.generate!(name:)
    create!(name: name)
  end

  def increase_point(value)
    points.create!(amount: value)
  end

  def decrease_point(value)
    points.create!(amount: -value)
  end

  def point
    points.sum(:amount)
  end

  private

  def set_token
    self.token = SecureRandom.uuid
  end
end
