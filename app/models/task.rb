class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :category
  belongs_to :issue
  attr_accessible :categoryName, :issueTitle, :projectName, :spendTime, :taskDay
  validates :categoryName,
    :presence => true
  validates :issueTitle,
    :presence => true
  validates :projectName,
    :presence => true
  validates :spendTime,
    :presence => true
  validates :taskDay,
    :presence => true
end
