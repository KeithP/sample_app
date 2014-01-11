class MicropostsController < ApplicationController
	before_filter :authenticate
	
	def create
	end
	
	def destroy
	end
	
	private
	
		## new in rails 4 - replaces model: attr_accessible :name, :email etc
		def user_params
			params.require(:micropost).permit(:content)
		end
end