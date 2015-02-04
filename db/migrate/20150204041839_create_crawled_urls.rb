class CreateCrawledUrls < ActiveRecord::Migration
  def change
    create_table :crawled_urls do |t|
      t.string :url_scheme, null: false
      t.text :host, null: false, index: true
      t.text :path, null: false
      t.text :fragment
      t.text :query_strings, array: true
      t.datetime :last_parsed_at
      t.datetime :last_check_at
      t.boolean :dead, default: false

      t.timestamps null: false
    end
  end
end
