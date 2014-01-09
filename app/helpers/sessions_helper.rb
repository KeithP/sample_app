module SessionsHelper

# note: using cookies per below permanently leaves teh user signed in 
# where as the commented out session lines is the alternative that 
# - signs out the user on closing the browser

	def sign_in(user)
		cookies.permanent.signed[:remember_token] = [user.id, user.salt]
		#session[:remember_token] = [user.id, user.salt]
		current_user = user
	end	
	
	def current_user=(user)
		@current_user = user
	end
	
	def current_user
		@current_user ||= user_from_remember_token
	end
	
	def signed_in?
		!current_user.nil?
	end
	
	def sign_out
		cookies.delete(:remember_token)
		#session[:remember_token] = nil
		current_user = nil	
	end
	
	private
	
		def user_from_remember_token
			User.authenticate_with_salt(*remember_token)
		end
		
		def remember_token
			cookies.signed[:remember_token] || [nil, nil]
			#session[:remember_token] || [nil, nil]
		end
end
