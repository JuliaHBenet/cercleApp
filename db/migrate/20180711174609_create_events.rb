class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.boolean :lloguer
      t.integer :status
      t.string :document
      t.boolean :representacio
      t.string :name
      t.text :description
      t.datetime :eventstart
      t.datetime :eventend
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
