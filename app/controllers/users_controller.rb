class UsersController < ApplicationController

  def new
	@title = "Sign up"
  end
	
	def show
		@user = User.find(params[:id])
	end
  
  private  
  
  ## new in rails 4 - replaces model: attr_accessible :name, :email
  def user_params
    params.require(:user).permit(:name, :email)
  end
	
end
