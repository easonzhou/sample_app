require 'spec_helper'

describe "Relationship" do
  
  before(:each) do
    @user = Factory(:user)
    @other_user = Factory(:user, :email => Factory.next(:email))
  end
  
  describe "Follow" do
    redirect_to @user
    click_button
    response.should redirect_to(@user)
    response.should have_selector("div.actions",:content => "unfollow")
  end
  
  describe "unfollow"