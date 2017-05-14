require 'rails_helper'

RSpec.describe EpisodeManagerController, type: :controller do
  fixtures :users, :tvshows, :episodes
  let(:matei) {users(:matei)}
  let(:tvshow) {tvshows(:arrow)}
  let(:episode) {episodes(:arrow1)}
  before do
    allow(controller).to receive(:current_user) {matei}
  end
  describe '#follow' do
    before do
      matei.tvshows << tvshow
    end
    subject {get :follow, params: { id: episode.id }}
    it 'redirects to tvshow details' do
      expect(subject).to have_http_status(302)
      expect(subject).to redirect_to(controller: :tvshow_manager,
                                     action: :tvshow_details,
                                     id: episode.tvshow_id,
                                     anchor: "season#{ episode.season }")
    end
    it 'adds episode to follow list' do
      subject
      expect(matei.followed_tvshows.first.episodes.count).to eq 1
    end
  end
  describe '#unfollow' do
    before do
      matei.tvshows << tvshow
      matei.followed_tvshows.first.episodes << episode
    end
    subject {get :unfollow, params: { id: episode.id }}
    it 'deletes the episode' do
      subject
      expect(matei.followed_tvshows.first.episodes.count).to eq 0
    end
  end
end
