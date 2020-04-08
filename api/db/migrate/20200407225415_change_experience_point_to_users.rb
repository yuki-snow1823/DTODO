class ChangeExperiencePointToUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :experience_point, :integer, default: 0
  end

  def down
    change_column :users, :experience_point, :integer
  end
end
