class User < ApplicationRecord
  has_secure_password
  has_many :youtube_videos, dependent: :destroy, inverse_of: :user
  has_many :youtube_video_votes, dependent: :destroy, inverse_of: :user
  validates :email, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP

  def get_vote_by(yt_video_id)
    vote = youtube_video_votes.by_yt_video_id(yt_video_id).take&.vote
    return nil if vote.blank? || vote == 'no'
    vote
  end
end
