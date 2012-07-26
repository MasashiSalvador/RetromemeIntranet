class CreateCategoriesTasks < ActiveRecord::Migration
  def change
    create_table :categories_tasks, :id => false do |t|
      t.references :category
      t.references :task

      #t.timestamps
    end
    add_index :categories_tasks, :category_id
    add_index :categories_tasks, :task_id
  end
end
