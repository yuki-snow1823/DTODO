class AddSortToTodos < ActiveRecord::Migration[6.0]
  def change
    add_column :todos, :sort, :integer, default: 0
  end
end
