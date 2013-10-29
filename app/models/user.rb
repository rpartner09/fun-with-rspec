class User < ActiveRecord::Base
  has_many :links

  def fullname
  	return first_name + " " + self.last_name
  end
end
