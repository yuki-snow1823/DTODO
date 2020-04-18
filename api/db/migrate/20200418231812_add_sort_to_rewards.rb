class AddSortToRewards < ActiveRecord::Migration[6.0]
  def change
    add_column :rewards, :sort, :integer, defult: 0
  end
end
