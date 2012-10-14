class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :edrpou

      t.timestamps
    end

    add_index :people, :edrpou,   :unique => true
  end
end
