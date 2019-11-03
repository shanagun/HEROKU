class GossipsController < ApplicationController
  
  #permet de savoir si l'utilisateur est connecté et lui laisser l'accès si c'est le cas 
  before_action :authenticate_user, only: [:new, :edit, :update, :create, :destroy]
  
  #permet de savoir si l'utilisateur et le propriétaire de l'élèment qu'il souhaite modigier
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
  end

  def show
    @gossip = Gossip.find(params[:id])
    @comments = Comment.where(gossip_id: params[:id]).all

  end

  def new
    @gossip = Gossip.new # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire (new.html.erb)
  end

  def create
    @gossip = Gossip.new(title: params[:gossip_title], content: params[:gossip_content], user: current_user)
    @gossip.user = User.find_by(id: session[:user_id])

    if @gossip.save 
      redirect_to root_path
      flash[:success] = "Ton Gossip a été sauvegardé avec succès !" 
     else
      render "new"
    end
  end

  def edit
    @gossip = Gossip.find(params[:id])# Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
  end

  def update
    # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params
    # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
    @gossip = Gossip.find(params[:id])
    gossip_params = params.require(:gossip).permit(:title, :content)
    @gossip.update(gossip_params)
    redirect_to action: "show"
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to :action => "index"
  end

  def authenticate_user
    unless current_user
      flash[:notice] = "Tu n'as pas accès à cette page"
      redirect_to new_session_path
    end
  end 

  def correct_user
    if is_owner?(Gossip.find(params[:id]).user_id)
      flash[:notice] = "Ton commentaire a été correctement modifié"

    else flash[:danger] = "Tu n'as pas accès à cette page"
      redirect_to gossips_path
    end
  end

end