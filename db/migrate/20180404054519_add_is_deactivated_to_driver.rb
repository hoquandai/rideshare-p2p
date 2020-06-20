class AddIsDeactivatedToDriver < ActiveRecord::Migration[5.1]
  def change
    add_column :drivers, :is_deactivated, :boolean
  end
end
