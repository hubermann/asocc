class ApiController < ApplicationController

  skip_before_filter :verify_authenticity_token

	protect_from_forgery with: :null_session

	before_filter :check_token

  def check_token
    #Aqui no se renderiza nada. Solo se devuelve un 401 sino hay user
    @api_key = request.headers['X-Api-Key']
    if @api_key
      @user = User.where(persistence_token: @api_key).first
      if @user
        puts "SI hay user #{@api_key}"
        #user encontrado
        #token = Digest::SHA2.hexdigest("#{@user.email}--#{SecureRandom.hex(32)}")
        #guardo nuevo token
        #@user.update_attribute(:persistence_token, token)
      end

      #****** necesito devolver el token en la cabecera aun

    #no se encontro user
    else
      head status: :unauthorized
      return false
    end

  end




end
