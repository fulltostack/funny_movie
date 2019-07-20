require 'rails_helper'

RSpec.describe YoutubeVideoVotesController, type: :controller do
  describe 'POST #vote' do
    let(:yt_video) { create(:youtube_video) }

    context 'with logged-in user' do
      let(:user) { create(:user) }

      before do
        allow(controller).to receive(:current_user) { user }
      end

      it 'should `up vote` a shared video' do
        params = { youtube_video_id: yt_video.id, vote: 'up', format: :js}
        expect { post :vote, xhr: true, params: params }.to change(YoutubeVideoVote, :count).by(1)
      end

      it 'should `down vote` a shared video' do
        params = { youtube_video_id: yt_video.id, vote: 'down', format: :js}
        expect { post :vote, xhr: true, params: params }.to change(YoutubeVideoVote, :count).by(1)
      end

      it 'should not vote with invalid vote parameter' do
        post :vote, xhr: true, params: { youtube_video_id: yt_video.id, vote: 'down_vote', format: :js}
        validate_json_response(@response.body, ['is not included in the list'], 'vote')

        post :vote, xhr: true, params: { youtube_video_id: yt_video.id, vote: '', format: :js}
        validate_json_response(@response.body, ['can\'t be blank', 'is not included in the list'], 'vote')
      end

      it 'should not vote an already voted video' do
        expect { post :vote, xhr: true, params: {youtube_video_id: yt_video.id, vote: 'down', format: :js}}.to change(YoutubeVideoVote, :count).by(1)

        post :vote, xhr: true, params: {youtube_video_id: yt_video.id, vote: 'down', format: :js}
        validate_json_response(@response.body, [I18n.t('youtube_video_vote.already_voted')], 'vote')
      end

      it 'should not vote an invalid video' do
        post :vote, xhr: true, params: {youtube_video_id: Faker::Number.digit, vote: 'down', format: :js}
        validate_json_response(@response.body, [I18n.t('youtube_video.not_found')], 'youtube_video')

        post :vote, xhr: true, params: {youtube_video_id: Faker::Address.city, vote: 'down', format: :js}
        validate_json_response(@response.body, ['is not a valid integer'], 'youtube_video_id')
      end
    end

    context 'without logged-in user' do
      it 'should not vote' do
        post :vote, xhr: true, params: { youtube_video_id: yt_video.id, vote: 'up' }
        expect(YoutubeVideoVote.count).to eq(0)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['status']).to eq(422)
        expect(parsed_response['message']).to eq(I18n.t('user.unauthorized'))
      end
    end
  end
end