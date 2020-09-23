class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.integer :word_count
      t.text :text

      t.timestamps
    end
  end
end
