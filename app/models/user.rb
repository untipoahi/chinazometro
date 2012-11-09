class User < ActiveRecord::Base
	attr_accessor :pass
	attr_accessible :nombre, :login, :pass, :pass_confirmation, :password, :salt
	validates :login , :length => { minimum: 3 },
                       :uniqueness => true
	validates :nombre, :presence => true,
                       :length => { minimum: 3 }
    validates :pass, :confirmation => true,
    				     :length => { :in => 6..20 }
    validates :pass_confirmation, :presence => true

    before_save :encrypt_password

def encrypt_password
	#ActiveRecord::Base.logger.debug "Password present: #{pass.present?}" 
    if pass.present? 
  		self.salt = BCrypt::Engine.generate_salt  
  		self.password = BCrypt::Engine.hash_secret(pass, salt)
  	end
end

def signIn(userName, password)
		@usuario = User.find(:first, :conditions => "login = '#{userName}'")
		unless @usuario.nil?
			@hash_pwd = BCrypt::Engine.hash_secret(password, @usuario.salt)
			if @hash_pwd == @usuario.password
				return true
			end
		end
		return false
	end
end