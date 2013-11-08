class User < ActiveRecord::Base
  has_many :links

  def fullname
  	"#{first_name} #{last_name}"
  end
end
