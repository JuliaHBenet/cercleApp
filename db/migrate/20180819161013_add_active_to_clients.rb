class AddActiveToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :active, :boolean
  end
end
