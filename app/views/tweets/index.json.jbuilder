json.array!(@tweets) do |tweet|
  json.extract! tweet, :id, :user_id, :body
  json.url tweets_index_url(tweet, format: :json)
end