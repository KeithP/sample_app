module ApplicationHelper

	def version
		"version 0.0.0.5"
	end

	# return a title on a per-page basis
	def title
		base_title = "Ruby on Rails Tutorial Sample App"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end	
	
	def logo 
		image_tag("logo.png", :alt => "Sample App", :class => "round")
	end
	
end
