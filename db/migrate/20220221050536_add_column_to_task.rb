class AddColumnToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks,:priority, :integer,null: false, default: '1'
  end
end
