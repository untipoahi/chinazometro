class VoteController < ApplicationController
	def new
		if session[:current_user]
			@usuario = User.find_by_login(session[:current_user])
			if @usuario
				@voto = Vote.new
				@voto.value = params[:value]
				@voto.users_id = @usuario.id
				@voto.chinazos_id = params[:chinazo_id]
				respond_to do |format|
					if @voto.saveOrUpdate
	            		format.json {render :json => 'exito'}
	            	else
	            		format.json {render :json => 'fallo'}
	            	end
	            end
        	end
		end
	end
end
