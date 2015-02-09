class AddIndexOnNegativeExpressions < ActiveRecord::Migration
  def change
    add_index :negative_expressions, :expressions, using: 'gin'
    add_index :negative_expressions, :domains, using: 'gin'
  end
end
