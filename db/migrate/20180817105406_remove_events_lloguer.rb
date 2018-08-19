class RemoveEventsLloguer < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :lloguer, :boolean
  end
end
