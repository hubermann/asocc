class SessionsController < ApplicationController

  skip_before_filter :verify_authenticity_token
	protect_from_forgery with: :null_session


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
        @user.persistence_token = token
        @user.save
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

  end



  def logout
    api_key = request.headers['X-Api-Key']
      if api_key
        @user = User.where(persistence_token: api_key).first
        if @user
          @user = User.update(@user.id, :persistence_token => '')
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


end
