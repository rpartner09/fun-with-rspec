class Comment < ActiveRecord::Base
  belongs_to :link

  after_save :update_link_score
  after_initialize { score ||= 0 }

  def vote_up
    self.score += 1
    self.save
  end

  protected
  def update_link_score
  	if self.link.present?
  	 self.link.update_score
    end
  end

end
