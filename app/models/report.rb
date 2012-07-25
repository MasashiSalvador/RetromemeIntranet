class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :issue
  attr_accessible :breaktime, :comment, :totalWorkTime, :workingDay, :worktimeBegin, :worktimeEnd
  validates :comment,
    :presence => true
  validates :breaktime,
    :presence => true
  validates :totalWorkTime,
    :presence => true
  validates :workingDay,
    :presence => true
  validates :worktimeBegin,
    :presence => true
  validates :worktimeEnd,
    :presence => true
    
end
