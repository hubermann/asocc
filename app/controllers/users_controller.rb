class UsersController < ApiController
	skip_before_filter :verify_authenticity_token

	protect_from_forgery with: :null_session

	def index
		@users = User.all
		render status:200, json: {
				message: "Actual Users",
				user: @users
			}.to_json
	end

	def create
    @user = User.new(user_params)
    if @user.save
    	@profile = UserProfile.create(user_id: @user.id)
    	#por el momento se pasa el user completo
    	#a futuro aqui no se devuelve nada mas que un header con el token y header con success
      render status:200, json: {
				message: "User created",
				user: @user,
				profile: @profile
			}.to_json
    else
      render status:422, json: {
				errors: @user.errors
				}.to_json
    end
  end

  def destroy
  	@user = User.find(params[:id]).destroy
  	render status:200, json: {
				message: "User deleted.  (aqui hay que agregar funcionalidades de validacion y ver los items que desencadenan del usuario.)",
				user: @user
			}.to_json
  end



	private
		def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
