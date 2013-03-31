class CreateRsses < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string   :url
      t.string   :title
      t.datetime :date

      t.timestamps
    end
  end
end
