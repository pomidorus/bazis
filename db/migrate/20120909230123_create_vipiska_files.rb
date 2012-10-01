class CreateVipiskaFiles < ActiveRecord::Migration
  def change
    create_table :vipiska_files do |t|
      t.string  :file_name
      t.string  :file_size
      t.date    :file_for_data
      t.integer :files_count_in, :default => 0
      t.string  :download_count, :default => '0'
      t.date    :upload_at, :default => '2012-10-01'
      t.integer :user_id, :default => '2'

      t.timestamps
    end
  end
end
