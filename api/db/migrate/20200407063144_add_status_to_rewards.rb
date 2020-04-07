class AddStatusToRewards < ActiveRecord::Migration[6.0]
  def change
    add_column :rewards, :status, :boolean, default: false, null: false
  end
end
