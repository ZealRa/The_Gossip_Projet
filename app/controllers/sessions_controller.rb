class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Connexion réussie ! Bienvenue, #{user.email} !"
      redirect_to root_path
    else
      flash.now[:alert] = "Email ou mot de passe incorrect"
      render :new
    end
  end


  def destroy
    session[:user_id] = nil
    flash[:notice] = "Vous avez été déconnecté avec succès !"
    redirect_to root_path
  end
end
