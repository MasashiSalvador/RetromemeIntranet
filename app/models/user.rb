class User < ActiveRecord::Base
  attr_accessible :company, :password, :permission, :provider, :uid, :username
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      
      if user.provider == "facebook"
        user.username = auth["info"]["name"]
      else
        user.username = auth["info"]["nickname"]
      end
    end
  end
end
