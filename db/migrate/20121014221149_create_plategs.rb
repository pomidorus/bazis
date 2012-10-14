class CreatePlategs < ActiveRecord::Migration
  def change
    create_table :plategs do |t|
      t.string :acc1
      t.string :acc2
      t.string :summa
      t.string :bank
      t.string :platnik
      t.string :platnik_c
      t.text :comment

      t.timestamps
    end
  end
end
