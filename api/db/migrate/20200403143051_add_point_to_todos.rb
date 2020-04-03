class AddPointToTodos < ActiveRecord::Migration[6.0]
  def change
    add_column :todos, :point, :integer
  end
end
