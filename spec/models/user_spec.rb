require 'spec_helper'

describe User do
  before(:each) do
    @user = User.new(first_name:"Fred", last_name: "Stevens", email:'fred@gmail.com')
  end

  it "has an email" do
    @user.email.should be_present
  end

  it "has a first name" do
    @user.first_name.should be_present
  end

  it "has a last name" do
    @user.last_name.should be_present
  end

  it "has a fullname" do
    @user.fullname.should == "Fred Stevens"
  end

  context "with a link" do
    before(:each) do
      @user = FactoryGirl.create(:user_with_link)
    end
    it "has a link" do
      @user.links.count.should == 1
    end
  end
end
