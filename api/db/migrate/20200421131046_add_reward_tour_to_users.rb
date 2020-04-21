class AddRewardTourToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :reward_tour, :boolean, default: true, null: false
  end
end
