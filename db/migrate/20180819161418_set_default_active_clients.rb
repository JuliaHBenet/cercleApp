class SetDefaultActiveClients < ActiveRecord::Migration[5.1]
  def change
    change_column_default :clients, :active, true
  end
end
