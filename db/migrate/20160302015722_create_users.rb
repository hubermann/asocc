class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :name
      t.string :lastname
      t.string :email
      t.string :encrypted_password
      t.string :salt

			t.string    :persistence_token,   :null => false
			t.string    :single_access_token, :null => false
			t.string    :perishable_token,    :null => false

			t.integer   :login_count,         :null => false, :default => 0
			t.integer   :failed_login_count,  :null => false, :default => 0
			t.datetime  :last_request_at
			t.datetime  :current_login_at
			t.datetime  :last_login_at
			t.string    :current_login_ip
			t.string    :last_login_ip

      t.timestamps null: false
    end
  end
end
