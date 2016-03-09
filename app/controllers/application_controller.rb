class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  after_filter :set_access_control_headers

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end

  def is_owner(token, id_owner) #id_owner del elemento a comprobar

    puts "llego de toKEN::#{token}"
    @candidato = User.where(persistence_token: token).first if token
    if @candidato
      puts "El user id: #{@candidato.id} - y el recibido #{id_owner}"
      true if @candidato.id == id_owner
    end
    puts "No se encontro owner"
    false
  end


end
