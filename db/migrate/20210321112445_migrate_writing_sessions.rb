class MigrateWritingSessions < ActiveRecord::Migration[6.0]
  def change
    User.first.update(admin_role: true)
    WritingSession.update_all user_id: User.first.id
  end
end
