class AddFaltaInfoToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :falta_info, :boolean
  end
end
