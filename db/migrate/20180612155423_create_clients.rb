class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.boolean :lloguer, default: false
      t.string :name
      t.string :idcard
      t.string :address
      t.integer :postcode
      t.string :city
      t.string :contactname
      t.string :contactphone1
      t.string :contactphone2
      t.string :contactemail
      t.text :comments

      t.timestamps
    end
  end
end
