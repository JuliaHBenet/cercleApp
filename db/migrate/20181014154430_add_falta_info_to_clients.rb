class AddFaltaInfoToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :falta_info, :boolean, default: false
  end
end
