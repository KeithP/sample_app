require 'spec_helper'


describe UsersController do
	render_views

	before(:each) do
		@base_title = "" #"Ruby on Rails Tutorial Sample App"
	end
  
  describe "GET 'new'" do
	
    it "returns http success" do
      get 'new'
      response.should be_success
    end
		
		it "should have the right title" do
			get 'new'
      response.should have_selector("title", 
                                    :content => @base_title + " | Sign up")  
    end		
  end
	
	
	describe "GET 'show'" do
	
		before(:each) do
			# FactoryGirl "create" returns a User instance that's saved
			@user = create(:user)
		end
		
		it "should be successful" do 
			get :show, :id => @user
			response.should be_success
		end
		
		it "should find the right user" do 
			get :show, :id => @user
			assigns(:user).should == @user
		end
		
		it "should have the right title" do
			get :show, :id => @user
			response.should have_selector("title", :content => @user.name)
		end
	end
end
