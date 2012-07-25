class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.integer :usertype
      t.string :company

      t.timestamps
    end
  end
end
