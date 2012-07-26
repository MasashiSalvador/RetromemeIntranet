class ProjectsTask < ActiveRecord::Base
  belongs_to :project
  belongs_to :task
  # attr_accessible :title, :body
end
