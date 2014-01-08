class UsersController < ApplicationController

  def new
		@user = User.new
		@title = "Sign up"
  end
	
	def show
		@user = User.find(params[:id])
		@title = @user.name
	end
	
	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			@title = "Sign up"
			#clear password on retry
			@user.password = "" 
			render 'new'
		end
	end
  
  private  
  
  ## new in rails 4 - replaces model: attr_accessible :name, :email etc
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
	
end
