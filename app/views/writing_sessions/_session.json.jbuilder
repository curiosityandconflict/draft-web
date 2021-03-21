json.extract! session, :id, :word_count, :text, :created_at, :updated_at
json.url session_url(session, format: :json)
