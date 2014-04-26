class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :note_id
      t.integer :position
    end
    add_index(:taggings, [:tag_id, :note_id, :position], :unique => true)
  end
end
