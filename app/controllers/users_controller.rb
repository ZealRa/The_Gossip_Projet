class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Inscription réussie ! Vous êtes maintenant connecté."
    else
      flash.now[:alert] = "Erreur lors de l'inscription. Veuillez vérifier vos informations."
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end


  def self.anonymous_user
    find_or_create_by(email: 'anonymous@example.com') do |user|
      user.first_name = 'Anonymous'
      user.last_name = 'User'
    end
  end
end
