json.extract! session, :id, :word_count, :text, :created_at, :updated_at
json.url story_writing_session_url(story, session, format: :json)
