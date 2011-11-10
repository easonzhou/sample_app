require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    # Define @base_title here.
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET 'home'" do
    before(:each) do
      get :home
    end
    
    it "should be successful" do
      response.should be_success
    end

    it "should have the right title" do
      response.should have_selector("title",
      :content => @base_title + " | Home")
    end
  end
  
  describe "when signed in" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
      other_user = Factory(:user, :email => Factory.next(:email))
      other_user.follow!(@user)
    end
    
    it "should have the right follower/following counts" do
      get :home
      response.should have_selector("a", :href => following_user_path(@user), :content => "0 following")
      response.should have_selector("a", :href => followers_user_path(@user), :content => "1 follower")
    end
    
    it "should not have a delete button on others' microposts" do
      @other_user = Factory(:user, :email => Factory.next(:email))
      @user.follow!(@other_user)
      @mps = Factory(:micropost, :user => @other_user, :content => "other user's micropost")
      get 'home'
      response.should_not have_selector("a", :content => "delete")
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
      :content => @base_title + " | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
      :content => @base_title + " | About")
    end
  end

  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end

    it "should have the right title" do
      get 'help'
      response.should have_selector("title",
      :content => @base_title + " | Help")
    end
  end

  describe "for signed in user" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @mp1 = Factory(:micropost, :user => @user, :content => "Foo bar")
    end

    it "should have a profile link" do
      get 'home'
      response.should have_selector("td", :class => "sidebar round")
    end

    it "should have one micropost" do
      get 'home'
      response.should have_selector("span.microposts", :content => "1 micropost")
    end

    it "should have two microposts" do
      @mp2 = Factory(:micropost, :user => @user, :content => "Foo lalal")
      get 'home'
      response.should have_selector("span.microposts", :content => "2 microposts")
    end
  end
end

