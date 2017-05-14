require 'rails_helper'

RSpec.describe TvshowManagerController, type: :controller do
  fixtures :users, :tvshows
  let(:matei) { users(:matei) }
  let(:tvshow) { tvshows(:arrow) }
  before do
    allow(controller).to receive(:current_user) { matei }
  end
  describe '#follow' do
    subject { get :follow, params: { imdb_id: tvshow.imdb_id } }
    it 'should redirect to search' do
      expect(subject).to have_http_status(302)
      expect(subject).to redirect_to(action: 'search',
                                     title: tvshow.title,
                                     message_text: "#{ tvshow.title } was added successfully to your Watchlist",
                                     message_type: 'alert-success')
    end
    it 'should add a new Tvshow to user', focus: true do
      subject
      expect(matei.tvshows.count).to eq 1
    end
  end
  describe '#unfollow' do
    subject { get :unfollow, params: { id: tvshow.id } }
    before do
      #Rails.application.load_seed
      matei.tvshows << tvshow
    end
    it 'should redirect to watchlist' do
      expect(subject).to have_http_status(302)
      expect(subject).to redirect_to(action: 'watchlist')
    end
    it 'should detele tvshow from watchlist' do
      subject
      expect(matei.tvshows.count).to eq 0
    end
  end
end
