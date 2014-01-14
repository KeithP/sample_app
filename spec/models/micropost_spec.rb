require 'spec_helper'

describe Micropost do

	before(:each) do
		@user = create(:user)
		@attr = { :content => "text content" }
	end
	
	it "should create a new instance given valid attributes" do
		@user.microposts.create!(@attr)
	end
	
	describe "user associations" do
	
		before(:each) do
			@micropost = @user.microposts.create(@attr)
		end

		it "should have a user attribute" do
			@micropost.user_id.should == @user.id
			@micropost.user.should == @user
		end
	end

	describe "validations" do
	
		it "should require a user id" do
			Micropost.new(@attr).should_not be_valid
		end
		
		it "should require non-blank content" do
			@user.microposts.build(:content => " " ).should_not be_valid
		end	
		
		it "should reject long content" do
			@user.microposts.build(:content => "a" * 141).should_not be_valid
		end
	end	

	describe "from_users_followed_by" do
	
		before(:each) do
			@other_user = create(:user, :email => generate(:email))
			@yet_other_user = create(:user, :email => generate(:email))
			
			@user_post = @user.microposts.create!(:content => "foo")
			@other_user_post = @other_user.microposts.create!(:content => "foo")
			@yet_other_user_post = @yet_other_user.microposts.create!(:content => "foo")
			
			@user.follow!(@other_user)
		end
		
		it "should have a from_users_followed_by class method" do
			Micropost.should respond_to(:from_users_followed_by)
		end
		
		it "should include the followed users microposts" do
			Micropost.from_users_followed_by(@user).should include(@other_user_post)
		end
		
		it "should include the users own microposts" do
			Micropost.from_users_followed_by(@user).should include(@user_post)
		end
		
		it "should not include an unfollowed user's microposts" do
			Micropost.from_users_followed_by(@user).should_not include(@yet_other_user_post)
		end
	end		
end
