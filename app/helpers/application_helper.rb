module ApplicationHelper

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
	
	def beacon_tracking_image
		# image_tag("https://ga-beacon.appspot.com/UA-46880352-1/KeithP/Sample_App/pages_controller", :alt => "Beacon image", :class => "round" )
	end
	
	def version
		"version 0.0.0.3"
	end

end
