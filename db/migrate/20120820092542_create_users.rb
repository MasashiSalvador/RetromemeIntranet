class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :company
      t.integer :permission
      t.string :uid
      t.string :provider

      t.timestamps
    end
  end
end
