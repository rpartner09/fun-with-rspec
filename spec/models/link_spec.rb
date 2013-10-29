require 'spec_helper'

describe Link do
  before(:each) do
  	@link = FactoryGirl.create(:link)
  end

  it "has a url"

  it "has a score"

  it "belongs to a user" do
  	user = FactoryGirl.create(:user)
  	user.links << @link

  	@link.user.should == user
  end

  context "with comments" do
  	before(:each) do
  		@link = FactoryGirl.create(:link_with_comment)
  	end

    it "has a comment"

    it "updates its cumulative score when a comment gets a score" do
      ## This one is tricky. You'll have to have several lines of code here. 
      ## The idea is that a link with 2 comments, one of a score 2, the other of a score 3, 
      ## will have a composite score of 5.

      ## A hint is that you may want to leverage the after_save callback of the 
      ## comment method to maybe update the parent link. 
    end
  end
end
