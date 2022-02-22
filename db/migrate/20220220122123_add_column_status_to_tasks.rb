class AddColumnStatusToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :status, :string, null: false, default: 'new'
    add_index :tasks, :status
  end
end
