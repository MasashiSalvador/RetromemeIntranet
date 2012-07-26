class User < ActiveRecord::Base
  attr_accessible :company, :password, :username, :usertype
end
