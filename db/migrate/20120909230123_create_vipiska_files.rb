class CreateVipiskaFiles < ActiveRecord::Migration
  def change
    create_table :vipiska_files do |t|
      t.string :file_name
      t.date :upload_at
      t.integer :download_count

      t.timestamps
    end
  end
end
