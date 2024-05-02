class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Connexion réussie !'

    else
      flash.now[:danger] = 'Combinaison email/mot de passe invalide.'
      render 'new'
    end
  end


  def destroy
  end
end
