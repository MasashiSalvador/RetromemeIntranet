# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120719034138) do

  create_table "categories", :force => true do |t|
    t.string   "categoryName"
    t.string   "categoryType"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "categories_tasks", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "task_id"
  end

  add_index "categories_tasks", ["category_id"], :name => "index_categories_tasks_on_category_id"
  add_index "categories_tasks", ["task_id"], :name => "index_categories_tasks_on_task_id"

  create_table "issues", :force => true do |t|
    t.integer  "report_id"
    t.time     "totalTime"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "issues", ["report_id"], :name => "index_issues_on_report_id"
  add_index "issues", ["user_id"], :name => "index_issues_on_user_id"

  create_table "projects", :force => true do |t|
    t.string   "projectName"
    t.string   "projectType"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "projects_tasks", :id => false, :force => true do |t|
    t.integer "project_id"
    t.integer "task_id"
  end

  add_index "projects_tasks", ["project_id"], :name => "index_projects_tasks_on_project_id"
  add_index "projects_tasks", ["task_id"], :name => "index_projects_tasks_on_task_id"

  create_table "reports", :force => true do |t|
    t.integer  "user_id"
    t.datetime "workingDay"
    t.time     "worktimeBegin"
    t.time     "worktimeEnd"
    t.time     "breaktime"
    t.time     "totalWorkTime"
    t.integer  "issue_id"
    t.text     "comment"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "reports", ["issue_id"], :name => "index_reports_on_issue_id"
  add_index "reports", ["user_id"], :name => "index_reports_on_user_id"

  create_table "tasks", :force => true do |t|
    t.integer  "user_id"
    t.datetime "taskDay"
    t.string   "projectName"
    t.string   "categoryName"
    t.integer  "project_id"
    t.integer  "category_id"
    t.integer  "issue_id"
    t.string   "issueTitle"
    t.time     "spendTime"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "tasks", ["category_id"], :name => "index_tasks_on_category_id"
  add_index "tasks", ["issue_id"], :name => "index_tasks_on_issue_id"
  add_index "tasks", ["project_id"], :name => "index_tasks_on_project_id"
  add_index "tasks", ["user_id"], :name => "index_tasks_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.integer  "usertype"
    t.string   "company"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
