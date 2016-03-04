class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :bio
      t.string :telephone
      t.string :avatar_url
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
