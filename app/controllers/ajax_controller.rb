class AjaxController < ApplicationController
	def users
		if params[:term]
			like= "%".concat(params[:term].concat("%"))
			users = Chinazo.find(:all, :select => 'DISTINCT nombre', :conditions => "nombre like '#{like}'" ) + User.where("nombre like ?", like)
		end
		list = users.map { |u| Hash[ id: u.id, label: u.nombre, name: u.nombre]  }		
		render json: list
	end
end
