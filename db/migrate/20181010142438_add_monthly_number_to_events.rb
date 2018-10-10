class AddMonthlyNumberToEvents < ActiveRecord::Migration[5.1]
  def change
     add_column :events, :monthly_number, :boolean
  end
end
