class ChangeLevelOfUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :level, :integer, default: 1
  end

  def down
    change_column :users, :level, :integer
  end
end
