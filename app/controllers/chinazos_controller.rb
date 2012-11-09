class ChinazosController < ApplicationController
	def new
		@chinazo = Chinazo.new
	end

	def create
		if session[:current_user]
			@chinazo = Chinazo.new(params[:chinazo])
			@chinazo.users_id = session[:current_user_id]
			if @chinazo.save
				redirect_to action: :show, id: @chinazo.id
			end
		else
			@chinazo = Chinazo.new
			flash[:errors] =  "Debes iniciar session para registrar un chinazo"
				render 'new'
		end
	end

	def update
		@chinazo = Chinazo.find(params[:id])
		if session[:current_user] && @chinazo.update_attributes(params[:chinazo])
			redirect_to action: :show, id: @chinazo.id
		else
			render 'edit';
		end
	end

	def show
		@chinazo = Chinazo.find(params[:id])
		@comentarios = Comentario.where('chinazos_id = ?', params[:id]).sort!{|a,b| b.updated_at <=> a.updated_at}
	end
	
	def index
		#inicio las variables la paginación
		page = (params[:page] ||= 1).to_i
	    items_per_page = 10

		@chinazos = (Chinazo.all.sort!{|a,b| b.puntos <=> a.puntos})
		@chinazos = Kaminari.paginate_array(@chinazos).page(page).per(items_per_page)

		@puntajes = 
		Vote.connection.select_all("select chinazos.nombre, sum(puntos.puntos) as puntos from  (select chinazos_id, sum(value) as puntos from votes group by chinazos_id) puntos join chinazos on puntos.chinazos_id = chinazos.id group by chinazos.nombre order by puntos desc")

		@comentarios = Comentario.all(:order => "created_at desc",
									  :limit => "10")
		
	end

	def edit
		@chinazo = Chinazo.find(params[:id])
	end

	def destroy
		@chinazo = Chinazo.find(params[:id])
		@chinazo.destroy

		redirect_to action: :index
	end
end