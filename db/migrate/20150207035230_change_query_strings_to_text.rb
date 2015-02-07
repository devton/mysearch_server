class ChangeQueryStringsToText < ActiveRecord::Migration
  def change
    change_column :crawled_urls ,:query_strings, :text, array: false
  end
end
