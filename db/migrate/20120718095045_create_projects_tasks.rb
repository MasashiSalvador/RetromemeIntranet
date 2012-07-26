class CreateProjectsTasks < ActiveRecord::Migration
  def change
    create_table :projects_tasks,:id => false do |t|
      t.references :project
      t.references :task

      #t.timestamps
    end
    add_index :projects_tasks, :project_id
    add_index :projects_tasks, :task_id
  end
end
