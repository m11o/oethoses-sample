# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  validates :follower, presence: true
  validates :followee, presence: true

  validate :cannot_follow_self

  private

  def cannot_follow_self
    errors.add(:followee, 'cannot follow self') if follower == followee
  end
end
