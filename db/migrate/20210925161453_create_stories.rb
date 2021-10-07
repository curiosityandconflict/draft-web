class CreateStories < ActiveRecord::Migration[6.1]
  def change
    create_table :stories do |t|
      t.string :title, null: false
      t.belongs_to :user, null: false
      t.timestamps
    end

    add_reference :writing_sessions, :story, foreign_key: true
  end
end
