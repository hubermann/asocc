class ProfilesController < ApiController
  api!
  def index
    @profile = Profile.find_by_user_id(params[:user_id])
    render status:200, json: {
			profile: @profile
		}.to_json
  end

  api!
  def update
    @userprofile = Profile.find_by_user_id(params[:user_id])
    @userprofile.update_attributes(profile_params)
		    render status:200, json: {
						message: "Profile updated",
            data: @userprofile
					}.to_json
  end

  api!
  private
    def profile_params
      params.require(:profile).permit(:name, :lastname, :bio, :avatar_url )
    end

end
