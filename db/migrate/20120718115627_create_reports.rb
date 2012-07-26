class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :user
      t.datetime :workingDay
      t.time :worktimeBegin
      t.time :worktimeEnd
      t.time :breaktime
      t.time :totalWorkTime
      t.references :issue
      t.text :comment

      t.timestamps
    end
    add_index :reports, :user_id
    add_index :reports, :issue_id
  end
end
