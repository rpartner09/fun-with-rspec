class Link < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  after_initialize { self.score ||= 0 }

  def update_score
  	updated_score = self.comments.sum(:score)
  	self.update_attribute(:score, updated_score)
  end

end
