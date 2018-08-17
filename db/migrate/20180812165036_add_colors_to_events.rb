class AddColorsToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :backgroundColor, :string
    add_column :events, :borderColor, :string
  end
end
