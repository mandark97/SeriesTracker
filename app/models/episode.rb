class Episode < ApplicationRecord
  belongs_to :tvshow
  has_many :followed_episodes
  has_many :followed_tvshows, through: :followed_episodes
  validates :imdb_id, uniqueness: true

  def self.find_or_create(imdb_id)
    unless (episode = Episode.find_by(imdb_id: imdb_id))
      ep = OMDB.client.id(imdb_id)
      episode= common_create(ep)
    end
    episode
  end

  def self.common_create(ep)
    episode = Episode.new
    episode.tvshow_id = Tvshow.find_by(imdb_id: ep.series_id).id
    episode.imdb_id = ep[:imdb_id]
    episode.title = ep[:title]
    episode.released = ep[:released]
    episode.episode = ep[:episode]
    episode.imdb_rating = ep[:imdb_rating]
    episode.season = ep[:season]
    episode.director = ep[:director]
    episode.writer = ep[:writer]
    episode.actors = ep[:actors]
    episode.plot = ep[:plot]
    episode.poster = ep[:poster]
    episode.awards = ep[:awards]
    episode.save
    episode
  end
end
