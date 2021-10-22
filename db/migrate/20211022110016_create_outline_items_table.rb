class CreateOutlineItemsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :outline_items do |t|
      t.references :story
      t.string :text
      t.boolean :completed
      t.integer :order
      t.string :timestamps

      t.timestamps
    end

    add_reference :stories, :next_outline_item, foreign_key: {to_table: :stories}
  end
end
