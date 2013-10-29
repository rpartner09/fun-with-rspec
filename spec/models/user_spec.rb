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
end
