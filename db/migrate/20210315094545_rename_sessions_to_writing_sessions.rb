class RenameSessionsToWritingSessions < ActiveRecord::Migration[6.0]
  def change
    rename_table :sessions, :writing_sessions
  end
end
