json.extract! feed, :id, :title, :descrition, :created_at, :updated_at
json.url feed_url(feed, format: :json)
