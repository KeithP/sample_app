class MicropostsController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :authorized_user, :only => :destroy
	
	def index
		@microposts = current_user.microposts.paginate(:page => params[:page])	
		
	end
	
	
	def create
		@micropost = current_user.microposts.build(user_params)
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to root_path
		else
			@feed_items = []
			render 'pages/home'
		end
	end
	
	def destroy
		@micropost.destroy
		redirect_back_or root_path
	end
	
	private
	
		def authorized_user
			@micropost = Micropost.find(params[:id])
			redirect_to root_path unless current_user?(@micropost.user)
		end
	
		## new in rails 4 - replaces model: attr_accessible :name, :email etc
		def user_params
			params.require(:micropost).permit(:content)
		end
end