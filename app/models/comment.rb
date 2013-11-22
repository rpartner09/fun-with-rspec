class Comment < ActiveRecord::Base
  belongs_to :link

  def vote_up
  	return self.score += 1
  end
end
