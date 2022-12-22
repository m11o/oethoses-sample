# frozen_string_literal: true

class User < ApplicationRecord
  has_many :followers, class_name: 'Follow', foreign_key: 'followee_id'
  has_many :followees, class_name: 'Follow', foreign_key: 'follower_id'
  has_many :tweets, dependent: :destroy
  has_many :retweets, dependent: :destroy

  validates :email, presence: true, uniqueness: true

  def follow!(user)
    return if following?(user)

    followees.create!(followee: user)
  end

  def unfollow!(user)
    return unless following?(user)

    followees.find_by(followee: user).destroy!
  end

  def following?(user)
    followees.exists?(followee: user)
  end

  def followed?(user)
    followers.exists?(follower: user)
  end

  def timeline
    Tweet.where(user: followees.pluck(:followee_id) + [id])
  end
end
