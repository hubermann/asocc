class UserProfileController < ApiController
  skip_before_filter :verify_authenticity_token

	protect_from_forgery with: :null_session

  def index
    @profile = UserProfile.find_by_user_id(params[:user_id])
    render status:200, json: {
			profile: @profile
		}.to_json
  end

  def show
    @profile = UserProfile.find_by_user_id(params[:user_id])
    render status:200, json: {
      profile: @profile
    }.to_json
  end


  def update
    @userprofile = UserProfile.find_by_user_id(params[:user_id])
    #verifico si es el dueño
    if is_owner(@api_key, @userprofile.user_id)
      @userprofile.update_attributes(profile_params)
  		    render status:200, json: {
  						message: "Profile updated",
              data: @userprofile
  					}.to_json
    else
      render status:200, json: {
          message: "Profile NOPE updated",
          api: @api_key,
          owner: @userprofile.user_id
        }.to_json
    end
  end



  private
    def user_profile_params
      params.require(:user_profile).permit(:bio, :name, :lastname, :company, :avatar_url, :background_url, :css_bg_color, :css_links_color, :css_primary_color, :css_secondary_color, :website, :country, :city, :address, :public_email, :public_phone)
    end


end
