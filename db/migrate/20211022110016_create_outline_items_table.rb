class CreateOutlineItemsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :outlines do |t|
      t.references :story
      t.integer :completion

      t.timestamps
    end

    create_table :outline_items do |t|
      t.references :outline
      t.string :text
      t.boolean :completed
      t.integer :position
      t.string :timestamps

      t.timestamps
    end
  end
end
