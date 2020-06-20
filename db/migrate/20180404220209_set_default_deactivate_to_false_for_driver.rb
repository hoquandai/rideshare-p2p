class SetDefaultDeactivateToFalseForDriver < ActiveRecord::Migration[5.1]
  def change
    change_column_default :drivers, :is_deactivated, from: nil, to: false
  end
end
