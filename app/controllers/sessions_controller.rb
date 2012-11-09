class SessionsController < ApplicationController
	def new
	end

	def create
		@user = User.find_by_login(params[:userName])
		unless @user.signIn(params[:userName], params[:pass])
			flash[:errors] = "Nombre de usuario o Contrasena incorrecta"
			redirect_to action: :new
		else
			session[:current_user] = @user.login
			session[:current_user_id] = @user.id
			redirect_to "/user/#{params[:userName]}"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, :notice => 'A finalizado la sesion'
	end	
end
