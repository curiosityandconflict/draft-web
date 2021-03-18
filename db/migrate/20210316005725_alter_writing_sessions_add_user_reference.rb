class AlterWritingSessionsAddUserReference < ActiveRecord::Migration[6.0]
  def change
    add_reference :writing_sessions, :user, foreign_key: true
    # add_column :writing_sessions, :user, :reference, :column_options
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
