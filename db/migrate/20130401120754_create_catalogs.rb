class CreateCatalogs < ActiveRecord::Migration
  def change
    create_table :catalogs do |t|
      t.references :feed
      t.integer    :point
      t.boolean    :done

      t.timestamps
    end
  end
end
