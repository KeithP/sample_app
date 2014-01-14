require 'spec_helper'

describe Relationship do

	before(:each) do
		@follower = create(:user)
		@followed = create(:user, :email => generate(:email))
		
		@relationship = @follower.relationships.build(:followed_id => @followed.id)
	end
	
	it "should create a new instance given valid attributes" do
		@relationship.save!
	end
	
	it "should be destroyed when the follower is destroyed" do
		@follower.destroy!
		Relationship.find_by_id(@relationship).should be_nil
	end		
	
	describe "follow methods" do
	
		before(:each) do
			@relationship.save
		end
		
		it "should have a follower attribute" do
			@relationship.should respond_to(:follower)
		end
		
		it "should have the right follower" do
			@relationship.follower.should == @follower
		end
		
		it "should have a followed attribute" do
			@relationship.should respond_to(:followed)
		end
		
		it "should have the right followed user" do
			@relationship.followed.should == @followed
		end
	end

	describe "validations" do

		it "should require follower id" do
			@relationship.follower_id = nil
			@relationship.should_not be_valid
		end
		
		it "should require a followed id" do
			@relationship.followed_id = nil
			@relationship.should_not be_valid
		end
	end	
end
