class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :categoryName
      t.string :categoryType

      t.timestamps
    end
  end
end
