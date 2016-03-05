class User < ActiveRecord::Base
  #vinculacion con user profile
  has_one :profile
  #soft_delete
  #acts_as_paranoid

  #los valores que se reciben. En la BD el campo password se llama "encrypted_password"
  attr_accessor :password, :password_confirmation

  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  validates :password_confirmation, :presence  => true, :on => :create, :on => :update

  validates :email,   :presence   => true,
            :format               => { :with => email_regex },
            :uniqueness           => { :case_sensitive => false }

  validates :password,  :presence => true,
            :confirmation         => true,
            :length               => { :within => 4..100 }

  #Antes de guardar encrypto password y genero tokens
  before_create :encrypt_password, :generate_token

  ##?????

  #verific passwords
  def has_password?(password)
    self.encrypted_password == encrypt(password)
  end


  # chequea user y email
  def login_user(email, submitted_password)
    puts user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end


  private
    def encrypt_password
      # generate a unique salt if it's a new user
      # self.password uses the attr_accessor we defined above to allow me to grab the inputed password
      self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{self.password}") if self.new_record?

      # encripta y asigna el password encriptado
      self.encrypted_password = encrypt(self.password)  #this self.password is what's in the post data!
    end

    # encripta salt + password en la registracion
    def encrypt(pass)
      Digest::SHA2.hexdigest("#{self.salt}--#{pass}")
    end

    #verifica el password el en el login
    def self.verify_password(password, salt, encrypted_password)
      #retorno true si la encryptacion del salt de user + el password recibido coincide con el pass guardado
      true if Digest::SHA2.hexdigest("#{salt}--#{password}") == encrypted_password
    end

    #tokens
    def generate_token
      self.persistence_token = SecureRandom.hex(32)
      self.single_access_token = SecureRandom.hex(32)
      self.perishable_token = SecureRandom.hex(32)
    end
end
