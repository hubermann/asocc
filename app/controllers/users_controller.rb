class UsersController < ApiController



	def index
		@useritos = User.all
		render status:200, json: {
				message: "Actual Users - ALL",
				user: @useritos,
			}.to_json
	end

  def show
		#verifico el X-api-key con el @user.persistence_token para reconocer el usuario
		api_key = request.headers['X-Api-Key']
    @autenticado = User.where(persistence_token: api_key).first if api_key
    render status:200, json: {
        authenticated: @autenticado
			}.to_json
  end

	def create
    @user = User.new(user_params)
    if @user.save
			@profile = Profile.create(user_id: @user.id)
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

  def create_recover_password
  	#aqui se genera el token para recuperar el password
#  	url = 'http://url de comprobacion del token'
#  	render status:200, json: {
#				message: "Mensaje enviado",
#				url: url
#			}.to_json
	 end

  def recover_password
  	#aqui tiene que llegar el token + el passowrd nuevo desde el formulario


		#   @user = User.find_by_password_reset_token!(params[:id])
		#  if @user.password_reset_sent_at < 2.hours.ago
		#    redirect_to new_password_reset_path, :alert => "Password reset has expired."
		#  elsif @user.update_attributes(params[:user])
		#    render status:200, json: {
		#				message: "Password updated",
		#				url: url
		#			}.to_json
		#  else
		#  	render status:422, json: {
		#				message: "error",
		#				errors: errors,
		#				url: url
		#			}.to_json
		#  end

end


  def destroy
  	@user = User.find(params[:id]).destroy
  	render status:200, json: {
				message: "User deleted.  (qui hay qu agregar funcioalidades de validacion y ver los items que desencadenan del usuario.)",
				user: @user
			}.to_json
  end




	private
		def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :persistence_token)
    end

end
