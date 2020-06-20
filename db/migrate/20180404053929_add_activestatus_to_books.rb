class AddActivestatusToBooks < ActiveRecord::Migration[5.1]
  def change
        add_column :passengers, :is_deactivated, :boolean
  end
end
