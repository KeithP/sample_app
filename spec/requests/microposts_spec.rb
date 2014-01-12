require 'spec_helper'

describe "Microposts" do

	before(:each) do
		user = create(:user)
		visit signin_path
		fill_in :email, :with => user.email
		fill_in :password, :with => user.password
		click_button
	end
	
	describe "creation" do
	
		describe "failure" do
		
			it "should not make a new micropost" do
				lambda do
					visit root_path
					fill_in :micropost_content, :with => ""
					click_button
					response.should render_template('pages/home')
					response.should have_selector("div#error_explanation")
				end.should_not change(Micropost, :count)
			end
		end
		
		describe "success" do
		
			it "should make a new micropost" do
				content = "Lorem ipsum dolr sit met"
				lambda do
					visit root_path
					fill_in :micropost_content, :with => content
					click_button
					response.should have_selector("span.content", :content => content)
				end.should change(Micropost, :count).by(1)
			end
			
			it "should display pluralised micropost counts" do
				visit root_path
				2.times do
					fill_in :micropost_content, :with => "content"
					click_button
				end
				response.should have_selector("span.microposts", 
																				:content => Micropost.count.to_s)
				response.should have_selector("span.microposts", 
																				:content => "microposts")
			end
			
			it "should paginate microposts" do
				visit root_path
				31.times do
					fill_in :micropost_content, :with => "content"
					click_button
				end
				response.should have_selector("div.pagination")
			end
			
			it "should not show delete link for posts by others" do
				visit root_path
				fill_in :micropost_content, :with => "content"
				click_button	
				visit signout_path
				# sign in as new user & should not see delete link
				new_user = create(:user, :email => generate(:email))
				visit signin_path
				fill_in :email, :with => new_user.email
				fill_in :password, :with => new_user.password
				click_button
				visit root_path
				response.should_not have_selector("a", :content => "delete" )	
			end
		end
	end
end
