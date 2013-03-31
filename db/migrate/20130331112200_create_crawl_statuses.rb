class CreateCrawlStatuses < ActiveRecord::Migration
  def change
    create_table :crawl_statuses do |t|
      t.datetime :date

      t.timestamps
    end
  end
end
