class SessionsController < ApplicationController

  skip_before_filter :verify_authenticity_token
	protect_from_forgery with: :null_session

  api!
  #login
  def authenticate
    #verifica si hay usuario con ese email
    @user = User.where(email: session_params[:email]).first if session_params[:email]
    #si se encontro user y hay variable de password
    if @user && session_params[:password]
      if User.verify_password(session_params[:password],@user.salt, @user.encrypted_password)
        # coinciden los datos
        token = Digest::SHA2.hexdigest("#{@user.email}--#{SecureRandom.hex(32)}")
        #guardo nuevo token (deberia retornarlo..)
        sum_logins = @user.login_count + 1
        @user.update_attribute(:persistence_token, token)
        @user.update_attribute(:login_count, sum_logins)

        render status:200, json: {
  				message: "Logueado correctamente",
          user: @user,
          token: token
  			}.to_json
      else
        # No coincide user con pass.
        render status:401, json: {
    				message: "Sin permisos",
    			}.to_json

      end

    else
      # No se encontro user
      render status:401, json: {
  				message: "Sin permisos",
  			}.to_json
    end
head :no_content
  end

  def register
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



  def logout
    api_key = request.headers['X-Api-Key']
      if api_key
        @user = User.where(persistence_token: api_key).first
        if @user
          puts api_key
          token = 'nada..remos'
          @user.update_persistence_token(token)
          render status:200, json: {
              message: "Good bye!",
              user: @user
            }.to_json
          else #no se encuentra user
            render status:401, json: {
        				message: "unauthorized",
        			}.to_json

          end
      else
        #head status: :unauthorized
        render status:401, json: {
    				message: "unauthorized",
    			}.to_json
        return false
      end
  end



  private
    def session_params
      params.require(:session).permit(:email, :password)
    end

    def user_params

      params.require(:user).permit(:email, :password, :password_confirmation)

    end


end
