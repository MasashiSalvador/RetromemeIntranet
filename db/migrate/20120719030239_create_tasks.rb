class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :user
      t.datetime :taskDay
      t.string :projectName
      t.string :categoryName
      t.references :project
      t.references :category
      t.references :issue
      t.string :issueTitle
      t.time :spendTime

      t.timestamps
    end
    add_index :tasks, :user_id
    add_index :tasks, :project_id
    add_index :tasks, :category_id
    add_index :tasks, :issue_id
  end
end
