class GossipsController < ApplicationController
  before_action :require_login, only: [:new, :create, :show]
  before_action :require_creator, only: [:edit, :update, :destroy]


  def show
    @gossip = Gossip.find(params[:id])
    @comment = Comment.new
  end

  def new
    @gossip = Gossip.new
  end

  def index
    redirect_to welcome_path(first_name: "Thomas")
  end

  def create
    @gossip = Gossip.new(gossip_params)
    @gossip.user = current_user if current_user # Associer le potin à l'utilisateur connecté s'il existe
    if @gossip.save
      redirect_to @gossip, notice: "Le potin a été enregistré avec succès !"
    else
      flash.now[:error] = "Erreur : Le titre doit être compris entre 3 et 14 caractères, et il ne faut pas qu'un des champs soit vide."
      render :new
    end
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    if @gossip.update(gossip_params)
      redirect_to @gossip
    else
      render :edit
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to gossips_path, notice: "Le potin a été supprimé avec succès !"
  end

  private
  def require_login
    unless current_user
      flash[:alert] = "Vous devez être connecté pour accéder à cette page."
      redirect_to login_path
    end
  end

  def require_creator
    @gossip = Gossip.find(params[:id])
    unless current_user == @gossip.user
      flash[:alert] = "Vous n'êtes pas autorisé à effectuer cette action."
      redirect_to root_path
    end
  end

  def gossip_params
    params.require(:gossip).permit(:title, :description, :user_id)
  end
end
