class RenameThresholdColumnToLevelSettings < ActiveRecord::Migration[6.0]
  def change
    rename_column :level_settings, :threshold, :thresold
  end
end
