class YoutubeVideo < ApplicationRecord
  belongs_to :user
  has_many :youtube_video_votes, dependent: :destroy
  validates :url, presence: true, format: /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i.freeze
end
