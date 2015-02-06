class CreateNegativeExpressions < ActiveRecord::Migration
  def change
    create_table :negative_expressions do |t|
      t.text :domains, array: true, null: false
      t.text :expressions, array: true, null: false

      t.timestamps null: false
    end
  end
end
