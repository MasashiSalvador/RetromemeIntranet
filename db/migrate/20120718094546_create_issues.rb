class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.references :report
      t.time :totalTime
      t.references :user

      t.timestamps
    end
    add_index :issues, :report_id
    add_index :issues, :user_id
  end
end
