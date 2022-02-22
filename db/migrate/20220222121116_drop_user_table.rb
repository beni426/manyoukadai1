class DropUserTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :user_tables
  end
end
