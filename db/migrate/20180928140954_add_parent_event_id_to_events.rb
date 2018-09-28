class AddParentEventIdToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :parent_event_id, :integer
    add_index :events, :parent_event_id
  end
end
