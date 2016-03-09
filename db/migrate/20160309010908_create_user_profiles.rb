class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.integer :user_id
      t.string :bio
      t.string :name
      t.string :lastname
      t.string :company
      t.string :avatar_url
      t.string :background_url
      t.string :css_bg_color
      t.string :css_links_color
      t.string :css_primary_color
      t.string :css_secondary_color
      t.string :website
      t.string :country
      t.string :city
      t.string :address
      t.string :public_email
      t.string :public_phone

      t.timestamps null: false
    end
  end
end
