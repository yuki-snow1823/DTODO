class ChangeDefaultPointToUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :point, :integer, default: 0
  end

  def down
    change_column :users, :point, :integer
  end
end
