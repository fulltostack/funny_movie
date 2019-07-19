class YoutubeVideo < ApplicationRecord
  belongs_to :user
  has_many :youtube_video_votes, dependent: :destroy
  validates :url, presence: true, format: /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i.freeze

  after_create :scrap_video_metadata
  YOUTUBE_DISPLAY_URL_PREFIX = 'https://www.youtube.com/embed'.freeze

  def scrap_video_metadata
    ScrapeYoutubeVideoMetadataWorker.perform_async(id)
  end

  def youtube_video_url
    video_id = YouTubeAddy.extract_video_id(url)
    "#{YOUTUBE_DISPLAY_URL_PREFIX}/#{video_id}"
  end

  def title
    self[:title] || I18n.t('youtube_video.no_title')
  end

  def description
    self[:description] || I18n.t('youtube_video.no_description')
  end
end
