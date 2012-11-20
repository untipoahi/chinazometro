class UserController < ApplicationController
	def login
		@user = User.new
	end
	def authenticate		
		@user = User.find_by_login(params[:userName])
		if @user
			unless @user.signIn(params[:userName], params[:pass])
				flash[:errors] = "Nombre de usuario o Contrasena incorrecta"
				redirect_to action: :login
			else
				session[:current_user] = @user.login
				session[:current_user_id] = @user.id
				redirect_to "/chinazos"
			end
		else
			flash[:errors] = "El usuario no existe"
			redirect_to action: :login
		end
	end
	def show
		@chinazos = Chinazo.find(:all, :conditions => "nombre = '#{params[:login]}'")
		#@comentarios = nil
		#@comentarios = Comentario.joins(:Chinazo).where("nombre = '#{params[:login]}'")
		return @chinazos
	end
	def registro
		if flash[:errors].nil?
			@user = User.new
		else
			@user = flash[:errors]
		end
	end
	def create
		@user = User.new(params[:user])
		if @user.valid?
			@user.save
			redirect_to action: :login
		else
			flash[:errors] = @user
			redirect_to action: :registro
		end
	end
	def search_user_by_name
        @users=User.where("LOWER(nombre) LIKE ?", "%#{params[:nombre].downcase}%").limit(params[:maxRows]).order(:nombre)
         
        respond_to do |format|
            format.json {render :json => @users}
        end
    end
end
