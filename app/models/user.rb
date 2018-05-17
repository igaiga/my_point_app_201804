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

  # 以下、解説用メソッド群
  # transaction内で例外を起こすとDBがロールバックされる
  def self.test_transaction
    ActiveRecord::Base.transaction do
      user = create!(name: "transaction_test03")
      user.increase_point(value)
      raise # ↑の2行が巻き戻る
    end
  end

  # 例: 2つのrails consoleから次のメソッドを呼んで待たされることを確認する
  def self.test_lock(user_id)
    ActiveRecord::Base.transaction do #lockするためにtransactionで囲む
      puts "***** waiting lock"
      user = User.lock.find(user_id) # DBから取得＆ロックしてモデルオブジェクトを作るとき
      #user.lock! # 既にDBから取得済みのモデルオブジェクトがあるとき
      puts "***** got lock"
      sleep 10
    end #transactionブロックを抜けるとロック解除
    puts "***** out of transaction"
  end

  private

  def set_token
    self.token = SecureRandom.uuid
  end
end
