class Issue < ActiveRecord::Base
  belongs_to :report
  belongs_to :user
  has_many :tasks
  attr_accessible :totalTime
  #validates :totalTime,
  #  :presence => true
end
