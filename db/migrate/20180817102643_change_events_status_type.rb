class ChangeEventsStatusType < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :status, :integer
    add_column :events, :status, :string
  end
end
