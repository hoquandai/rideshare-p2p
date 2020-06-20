class SetDefaultDeactivateToFalseForPassenger < ActiveRecord::Migration[5.1]
  def change
    change_column_default :passengers, :is_deactivated, from: nil, to: false
  end
end
