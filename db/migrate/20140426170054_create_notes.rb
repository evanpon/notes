class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :content, :limit => 4000
      t.datetime :archived_at
      t.timestamps
    end
  end
end
