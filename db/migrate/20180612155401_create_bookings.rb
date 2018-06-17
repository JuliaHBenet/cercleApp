class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.boolean :lloguer, default: false
      t.integer :status
      t.string :document
      t.boolean :representacio, default: false
      t.string :activityname
      t.text :activitydescription
      t.datetime :bookingstart
      t.datetime :bookingend
      t.datetime :activitystart
      t.datetime :activityend
      t.text :comments
      t.references :client, foreign_key: true
      t.references :room, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
