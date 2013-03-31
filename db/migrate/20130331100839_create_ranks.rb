class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.string  :word
      t.integer :point

      t.timestamps
    end
  end
end
