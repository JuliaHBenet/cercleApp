class AddWeeklyAndRecurrenceEndDateToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :weekly, :boolean
    add_column :events, :recurrence_ends_at, :datetime
  end
end
