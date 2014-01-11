class UsersController < ApplicationController
	before_filter :authenticate, 	:only => [:index, :edit, :update, :destroy]
	before_filter :correct_user, 	:only => [:edit, :update]
	before_filter :admin_user, 		:only => :destroy
	before_filter :not_signed_in, :only => [:create, :new]

  def new		
		@user = User.new
		@title = "Sign up"
  end
	
	def index
		@title = "All users"
		@users = User.paginate(:page => params[:page])	
	end
	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(:page => params[:page])
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
	
	def edit
		# @user is set by correct_user filter
		@title = "Edit user"
	end
	
	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated."
			redirect_to @user
		else
			@title = "Edit user"
			render 'edit'
		end
	end
	
	def destroy
		user = User.find(params[:id])
		if current_user?(user)
			flash[:notice] = "This is you! You can't destroy yourself this way"
		else
			user.destroy 		
			flash[:success] = "User destroyed."
		end
		redirect_to users_path
	end
  
  private  
		
		def not_signed_in
			redirect_to(root_path) if signed_in?		
		end
		
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end
  
		## new in rails 4 - replaces model: attr_accessible :name, :email etc
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
		
		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end	
end
