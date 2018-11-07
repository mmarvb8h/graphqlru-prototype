class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, unique: true, null: false
      t.string :name
      t.string :auth_provider
      t.string :auth_signin

      t.timestamps
    end
  end
end
