require 'spec_helper'

describe Comment do
  before(:each) do
  	@comment = FactoryGirl.create(:comment)
  end

  it "has a score" do
    @comment.score.should be_present
  end

  it "belongs to a link" do
    link = FactoryGirl.create(:link)
    link.comments << @comment

    @comment.link.should == link
  end

  it "increments the score" do
    ## this simulates the vote-up functionality.
    @comment.vote_up
    @comment.score.should == 2
  end
end
