class AddMonthlyDayToEvents < ActiveRecord::Migration[5.1]
  def change
     add_column :events, :monthly_day, :boolean
  end
end
