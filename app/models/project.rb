class Project < ActiveRecord::Base
  attr_accessible :projectName, :projectType
  def retProjectType
    return projectType
  end
end
