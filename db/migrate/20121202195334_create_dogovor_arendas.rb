class CreateDogovorArendas < ActiveRecord::Migration
  def change
    create_table :dogovor_arendas do |t|
      t.string :number

      t.timestamps
    end
  end
end
