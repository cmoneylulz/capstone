# This +InterestPointsController+ should be used to control new +InterestPoint+ instances that are added to this application
# @author	Ashley Childress
# @version 1.25.2014
class InterestPointsController < ApplicationController
	
	# Use default authorizations from CanCan gem
	load_and_authorize_resource
	
	# Set valid +contributors+ for this +Interest Point+
	before_action :set_valid_contributors, only: [:create, :update]
	before_action :set_default_image, only: [:create, :update]

	# Ensure the +Interest Point+ used by this +Interest Points Controllers+ is set before the show, update, edit, or delete actions
	# Create a new, empty +Interest Point+ and build any associated +Images+
	def new
	end
	
	# Create a new +Interest Point+ with attributes equal to the given parameters
	# @param [String] name the title used to identify the +Interest Point+
	# @param [String] summary a description of this +Interest Point+ that will be displayed to users on the details page
	# @param [String] address_line_1 the primary physical location of the +Interest Point+ used to generate coordinates on the map
	# @param [String] address_line_2 the secondary description of the physical location of the +Interest Point+, if applicable
	# @param [String] city the place that describes the physical location of this +Interest Point+
	# @param [String] state the state this +Interest Point+ is located in
	# @param [String] zip the postal zip code for the +Interest Point+ location
	# @param [Float] latitude the location given as a northern coordinate degree, optional if address is given
	# @param [Float] longitude the location given as a western coordinate degree, optional if address is given
	# @param [Integer] category_id the identification number of the +Category+ this +Interest Point+ is defined under
	# @param [Integer] contributor_id the number identifying the +User+ who initially created this +Interest Point+
	# @param [Integer] approver_id the number identifying the +User+ who approved this +Interest Point+ to be displayed for all application users.
	def create
		## You can't call @interest_point.id here because it doesn't have one yet; this needs to be moved out
    # if current_user
      # @rating = Rating.create(interest_point_id: @interest_point.id, user_id: @current_user.id, score: 0)
    # end
		if @interest_point.save
			set_default_image
			flash[:notice] = "Interest Point was created successfully!"
			
			## This is causing tests to fail
			@interest_point.notify_administrators!
			redirect_to interest_point_path(@interest_point)
		else
			flash[:error] = get_all_errors
			render 'new'
		end
	end
	
	# Display details for a specific +Interest Point+ identified by the given +id+
	# @param [Integer] id the unique identification nunber of the +Interest Point+ to display details for
	def show
	  # Move ratings out, causing test to fail
    #define interest point rating to be the current user's rating for the interest point or create a new one
    #if current_user
      # @rating = Rating.where(interest_point_id: @interest_point.id, user_id: @current_user.id).first
      # unless @rating
        # @rating = Rating.create(interest_point_id: @interest_point.id, user_id: @current_user.id, score: 0)
      # end

      map_image = @interest_point.default_image.nil? ? "" : @interest_point.default_image.file_url
      @hash = Gmaps4rails.build_markers(@interest_point) do |interest_point, marker|
        marker.lat interest_point.latitude
        marker.lng interest_point.longitude
        lat = "#{interest_point.latitude}"
        long = "#{interest_point.longitude}"
        image = "#{map_image}"
        name = interest_point.name
        url = "#{interest_point.id}"
        marker.infowindow "<h4>Go Here?</h4><a href=#{url}>#{name}</a><br /><img src=#{image} class='image-map-marker'/><br /><button onclick='getLocation(#{lat},#{long})'>GET DIRECTIONS</button>"
      end
	 end
	
	# Display a list of all +Interest Points+
	def index
		@interest_points = InterestPoint.active
		current_ability.can :read, @interest_points
	end
		
	# Permanently delete the +Interest Point+ with the given +id+ from this application
	# @param [Integer] id the unique identification number of the +Interest Point+ that will be permanently removed from this application
	def destroy
		@interest_point.destroy
		flash[:notice] = "Successfully removed Interest Point"	
		redirect_to interest_points_path
	end
	
	# Edit details for the +Interest Point+ identified by the given +id+
	# @param [Integer] id the unique identification number of the +Interest Point+ to be modified
	def edit
		
	end
	
	# Modify details for the +Interest Point+ identified by the given +id+. If one or more attributes are modified by the user, the corresponding database record will also be updated
	# @param [Integer] id the unique identification number of the +Interest Point+ to modify in the database using the specified attributes
	# @param (see #create)
	def update
		store_location
		set_default_image if @interest_point.default_image.nil?
		@interest_point.approver = nil
		@interest_point.approved_at = nil
		if @interest_point.update(interest_point_params)
			flash[:notice] = "Successfully updated Interest Point"
			redirect_back_or_to_default interest_point_path(@interest_point)
		else
			flash[:error] = get_all_errors
			redirect_back_or_to_default edit_interest_point_path(@interest_point)
		end
	end
		
	### Private Methods ###
	private
	
	# Define parameters that may be used when creating or modifying an +Interest Point+
	# @see (see #create)
	def interest_point_params
		params.require(:interest_point).permit(:name, :summary, :address_line_1, :address_line_2, :city, :state, :zip, :latitude, :longitude, :category_id, :contributor_id, :approver_id, :approved_at, :default_image_id, images_attributes: [:id, :file, :interest_point, :contributor_id, :approver_id, :_destroy])
	end

	# Returns a list of all errors found when saving this +Interest Point+
	def get_all_errors
		@interest_point.errors.full_messages.compact.join(',')
	end
	
	# Set valid +contributors+ for this +Interest Point+ if +object.new_record? => true+
	# @pre +@interest_point.new_record? => true+	# 
	# @post +@interest_point.contributor => not_nil+  
	def set_valid_contributors
		params[:contributor_id] = current_user if @interest_point.new_record?
	end
		
	# Automatically sets the default +Image+ to the first image associated with this +Interest Point+, if one exists, otherwise, the default image will be +nil+
	# @pre a default +Image+ does not exist for this +Interest Point+
	# @post the default +Image+ will be set to the first +Image+ object associated with this +Interest Point+, if an +Image+ exists, otherwise, the default +Image+ will be +nil+
	def set_default_image
		@interest_point.default_image_id = @interest_point.images.first.id unless @interest_point.images.empty?
	end
end
