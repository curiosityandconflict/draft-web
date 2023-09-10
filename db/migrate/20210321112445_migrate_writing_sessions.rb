class MigrateWritingSessions < ActiveRecord::Migration[6.0]
  def change
    # only run this migration if a user exists
    return unless (user = User.first)

    user.update(admin_role: true)
    WritingSession.update_all user_id: user.id
  end
end
