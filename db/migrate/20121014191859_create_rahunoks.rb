class CreateRahunoks < ActiveRecord::Migration
  def change
    create_table :rahunoks do |t|
      t.string :number
      t.string :code
      t.integer :vipiska_file_id

      t.timestamps
    end
  end
end
