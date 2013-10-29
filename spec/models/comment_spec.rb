require 'spec_helper'

describe Comment do
  before(:each) do
  	@comment = FactoryGirl.create(:comment)
  end

  it "has a score"

  it "belongs to a link"

  it "increments the score" do
    ## this simulates the vote-up functionality.
    @comment.vote_up
    @comment.score.should == 2
  end
end
