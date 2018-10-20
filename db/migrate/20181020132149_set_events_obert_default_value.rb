class SetEventsObertDefaultValue < ActiveRecord::Migration[5.1]
  def change
    change_column_default :events, :obert, true
  end
end
