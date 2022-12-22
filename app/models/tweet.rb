# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :quote_tweet, class_name: 'Tweet', optional: true

  has_many :retweets, dependent: :destroy

  validates :content, presence: true

  def retweet!(user)
    retweets.create!(user:)
  end
end
