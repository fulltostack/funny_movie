class User < ApplicationRecord
  has_secure_password
  has_many :youtube_videos, dependent: :destroy, inverse_of: :user
  has_many :youtube_video_votes, dependent: :destroy, inverse_of: :user
  validates :email, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
end
