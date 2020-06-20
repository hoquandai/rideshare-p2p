class AddStatusToDriver < ActiveRecord::Migration[5.1]
  def change
    add_column :drivers, :is_available, :boolean
  end
end
