class AddExperiencePointToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :experience_point, :integer
  end
end
