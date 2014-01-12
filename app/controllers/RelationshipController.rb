class RelationshipController < ActionController::Base

	private
	
		## new in rails 4 - replaces model: attr_accessible :name, :email etc
		def user_params
			params.require(:micropost).permit(:followed_id)
		end

end