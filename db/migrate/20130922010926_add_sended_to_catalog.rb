class AddSendedToCatalog < ActiveRecord::Migration
  def change
    add_column :catalogs, :sended, :boolean
  end
end
