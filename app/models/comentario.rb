class Comentario < ActiveRecord::Base
	attr_accessor :nombre
	validates :nombre, :comentario, presence: true, length: { minimum: 3 }

	def nombre
		User.find_by_id(self.users_id).nombre if self.chinazos_id?
	end
end
