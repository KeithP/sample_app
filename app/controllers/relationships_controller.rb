class RelationshipsController < ApplicationController
	before_filter :authenticate
	
	respond_to :html, :js

	def create
		@user = User.find(params[:relationship][:followed_id])
		current_user.follow!(@user)
		respond_with @user 
	end

	def destroy
		@user = Relationship.find(params[:id]).followed
		current_user.unfollow!(@user)
		respond_with @user 
	end
	
	private
	
		## new in rails 4 - replaces model: attr_accessible :name, :email etc
		def relationship_params
			params.require(:relationship).permit(:followed_id)
		end

end