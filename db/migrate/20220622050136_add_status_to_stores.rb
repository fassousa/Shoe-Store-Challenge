class AddStatusToStores < ActiveRecord::Migration[7.0]
  def change
    add_column :stores, :status, :integer
  end
end
