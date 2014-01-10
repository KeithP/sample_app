class SessionsController < ApplicationController
  # this keeps ssl on for all pages. to fix for non ssl pages: force downgrade for named links in helpers, 
	# eg: link_to('Events', events_url(:protocol => 'http')) 
	force_ssl if: :ssl_configured? 	
	def ssl_configured?
    Rails.env.production?
  end
	
	def new
		@title = "Sign in" 
  end
	
	def create
		user = User.authenticate(params[:session][:email], params[:session][:password])
		if user.nil?
			flash.now[:error] = "Invalid email/password combination."
			@title = "Sign in"
			render 'new'
		else
			sign_in user
			redirect_back_or user
		end
	end
	
	def destroy
		sign_out
		redirect_to root_path
	end
	
end
