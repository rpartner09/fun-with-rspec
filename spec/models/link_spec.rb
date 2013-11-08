require 'spec_helper'

describe Link do
  
  context "without comments" do
    before(:each) do
      @link = FactoryGirl.create(:link)
    end

    it "has a url" do
      @link.url.should be_present
    end

    it "has a score" do 
      @link.score.should be_present
    end

    it "belongs to a user" do
  	 user = FactoryGirl.create(:user)
  	 user.links << @link

  	 @link.user.should == user
    end

  end

  context "with comments" do
  	before(:each) do
  		@link = FactoryGirl.create(:link_with_comment)
  	end

    it "has a comment" do
      @link.comments.should be_present
    end

    it "updates its cumulative score when a comment gets a score" do
      comment_1 = @link.comments.first
      comment_1.vote_up
       
      comment_2 = FactoryGirl.create(:comment, link:@link)
      2.times { comment_2.vote_up }
  
      @link.score.should == 5
    end

  end
end
