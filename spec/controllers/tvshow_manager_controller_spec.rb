require 'rails_helper'

RSpec.describe TvshowManagerController, type: :controller do
  fixtures :users, :tvshows , :episodes
  let(:matei) { users(:matei) }
  let(:tvshow1) { tvshows(:arrow) }
  before do
    allow(controller).to receive(:current_user) { matei }
  end
  describe '#follow' do
    subject { get :follow, params: { imdb_id: tvshow1.imdb_id } }
    it 'should redirect to search' do
      expect(subject).to have_http_status(302)
      expect(subject).to redirect_to(action: 'search',
                                     title: tvshow1.title,
                                     message_text: "#{ tvshow1.title } was added successfully to your Watchlist",
                                     message_type: 'alert-success')
    end
    it 'should add a new Tvshow to user', focus: true do
      subject
      expect(matei.tvshows.count).to eq 1
    end
    it "doesn't add duplicates" do
      matei.tvshows << tvshow1
      subject
      expect(subject).to have_http_status(302)
      expect(subject).to redirect_to(action: 'search',
                                     title: tvshow1.title,
                                     message_text: "An error occured while adding #{ tvshow1.title } to your Watchlist",
                                     message_type: 'alert-danger')
      expect(matei.tvshows.count).to eq 1
    end
  end
  describe '#unfollow' do
    subject { get :unfollow, params: { id: tvshow1.id } }
    before do
      #Rails.application.load_seed
      matei.tvshows << tvshow1
    end
    it 'should redirect to watchlist' do
      expect(subject).to have_http_status(302)
      expect(subject).to redirect_to(action: 'watchlist')
    end
    it 'should detele tvshow from watchlist' do
      subject
      expect(matei.tvshows.count).to eq 0
    end
    it "doesn't delete if the tvshow is not watched" do
      matei.followed_tvshows.first.delete
      subject
      expect(subject).to have_http_status(302)
      expect(subject).to redirect_to(action: 'watchlist',
                                     message_text: 'An error occured while removing the show from your Watchlist',
                                     message_type: 'alert-danger')
    end
  end
  # describe '#watchlist' do
  #   let(:tvshow2){ tvshows(:flash) }
  #   let(:episode1){ episodes(:arrow1) }
  #   before do
  #     fake_time = Time.parse('2012-10-10 00:00:00')
  #     allow(Time).to receive(:now).and_return(fake_time)
  #     matei.tvshows << tvshow1
  #     matei.followed_tvshows.find_by(tvshow: tvshow1.id).episodes <<  episode1
  #     matei.tvshows << tvshow2
  #   end
  #   subject { get :watchlist }
  #   it 'shows episodes that will appear this week' do
  #     subject
  #   end
  # end
end
