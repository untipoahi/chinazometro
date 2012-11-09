class Chinazo < ActiveRecord::Base
	has_many :comentario
	attr_accessor :acusador, :puntos, :cantidad_comentarios
	attr_accessible :descripcion, :nombre
	validates :nombre, presence: true, length: { minimum: 3 }
	#before_save :serUserId

	def getByUser(userName)
		@usuario = User.find(:first, :conditions => "login = '#{userName}'")
		unless @usuario.nil?
			@chinazos = Chinazo.find(:all, :conditions => "users_id = '#{@usuario.id}'")
			return @chinazos
		end
	end

	def puntos
		@puntos = Vote.sum(:value,  :conditions =>"chinazos_id = #{id}")
		if @puntos.nil?
			self.puntos = 0
		else
			self.puntos = @puntos	
		end
	end

	def acusador
		User.find(users_id).nombre if users_id
	end

	def cantidad_comentarios
		Comentario.where("chinazos_id = #{id}").count if self.id
	end
end
