class AddComments2ToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :comments2, :string
  end
end
