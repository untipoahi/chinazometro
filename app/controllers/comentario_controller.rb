class ComentarioController < ApplicationController	
	def create
		@comentario = Comentario.new
		@comentario.users_id = session[:current_user_id]
		@comentario.comentario = params[:comentario]
		@comentario.chinazos_id = params[:chinazo_id]
		respond_to do |format|
			if @comentario.save
				 @comentarios = Comentario.where('chinazos_id = ?', params[:chinazo_id]).sort!{|a,b| b.updated_at <=> a.updated_at}
				 format.html { render :partial => 'comentario/index' }
			else

			end
		end
	end

	def listPartial
		@comentarios = Comentario.where('chinazos_id = ?', params[:chinazo_id]).sort!{|a,b| b.updated_at <=> a.updated_at}
		respond_to do |format|
			format.html { render :partial => 'comentario/index' }
		end
	end

	def ultimosComentarios
		@comentarios = Comentario.all(:order => "created_at desc",
									  :limit => "10")
		respond_to do |format|
			format.html { render :partial => "chinazos/indexComentarios" }
		end
	end
end
