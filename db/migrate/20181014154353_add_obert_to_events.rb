class AddObertToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :obert, :boolean
  end
end
