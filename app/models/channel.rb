class Channel < ApplicationRecord
  has_many :user_channels
  has_many :channel_blocks
  has_many :channel_followers
  # NEED TO FIGURE OUT HOW TO ALIAS AS 'FOLLOWER' NOT 'USER'
  has_many :followers, through: :channel_followers
  has_many :users, through: :user_channels
  has_many :blocks, through: :channel_blocks
end
