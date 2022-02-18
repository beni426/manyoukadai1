class ChangeColumnToTask < ActiveRecord::Migration[6.0]
  def up
    change_column :tasks, :title, :string, null: false, limit: 40
  end

  # 変更前の状態
  def down
    change_column :tasks, :title, :string, null: true,  limit: 0
  end
end
