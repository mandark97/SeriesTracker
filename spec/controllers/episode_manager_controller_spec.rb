require 'rails_helper'

RSpec.describe EpisodeManagerController, type: :controller do
  fixtures :users, :tvshows, :episodes
  let(:matei) { users(:matei) }
  let(:tvshow1) { tvshows(:arrow) }
  let(:episode1) { episodes(:arrow1) }
  before do
    allow(controller).to receive(:current_user) { matei }
    matei.tvshows << tvshow1
  end
  describe '#follow' do
    subject { get :follow, params: { id: episode1.id } }
    it 'redirects to tvshow details' do
      expect(subject).to have_http_status(302)
      expect(subject).to redirect_to(controller: :tvshow_manager,
                                     action: :tvshow_details,
                                     id: episode1.tvshow_id,
                                     anchor: "season#{ episode1.season }")
    end
    it 'adds episode to follow list' do
      subject
      expect(matei.followed_tvshows.first.episodes.count).to eq 1
    end
    it "doesn't add duplicates" do
      matei.followed_tvshows.first.episodes << episode1
      subject
      expect(subject).to have_http_status(302)
      expect(subject).to redirect_to(controller: :tvshow_manager,
                                     action: :tvshow_details,
                                     id: episode1.tvshow_id,
                                     message_text: 'An error occurred while marking the episode as watched',
                                     message_type: 'alert-danger')
      expect(matei.followed_tvshows.first.episodes.count).to eq 1
    end
  end
  describe '#unfollow' do
    before do
      matei.followed_tvshows.first.episodes << episode1
    end
    subject { get :unfollow, params: { id: episode1.id } }
    it 'redirects to tvshow details' do
      expect(subject).to have_http_status(302)
      expect(subject).to redirect_to(controller: :tvshow_manager,
                                     action: :tvshow_details,
                                     id: episode1.tvshow_id,
                                     anchor: "season#{ episode1.season }")
    end
    it 'deletes the episode' do
      subject
      expect(matei.followed_tvshows.first.episodes.count).to eq 0
    end
    it "doesn't delete if the episode is not watched" do
      matei.followed_tvshows.first.followed_episodes.first.delete
      subject
      expect(subject).to have_http_status(302)
      expect(subject).to redirect_to(controller: :tvshow_manager,
                                     action: :tvshow_details,
                                     id: episode1.tvshow_id,
                                     message_text: 'An error occurred while marking the episode as unwatched',
                                     message_type: 'alert-danger')
      expect(matei.followed_tvshows.first.episodes.count).to eq 0
    end
  end
  describe '#toogle_all' do
    let(:episode2) { episodes(:arrow2) }
    subject { get :toggle_all, params: { show_id: tvshow1.id, season_nr: 1 } }
    it 'redirects to tvshow_details' do
      expect(subject).to have_http_status(302)
      expect(subject).to redirect_to(controller: :tvshow_manager,
                                     action: :tvshow_details,
                                     id: tvshow1.id)
    end
    it 'adds episodes to followed episodes' do
      subject
      expect(matei.followed_tvshows.first.episodes.count).to eq 2
    end
    it 'unfollows episodes if already watched' do
      matei.followed_tvshows.first.episodes << episode1
      matei.followed_tvshows.first.episodes << episode2
      subject
      expect(matei.followed_tvshows.first.episodes.count).to eq 0
    end
  end
end
