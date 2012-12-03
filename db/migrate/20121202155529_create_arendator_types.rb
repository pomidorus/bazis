class CreateArendatorTypes < ActiveRecord::Migration
  def change
    create_table :arendator_types do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
