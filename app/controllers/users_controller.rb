class UsersController < ApplicationController
  
  def index
    # Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
    end
  
  def show
    @user = User.find(params[:id])# Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
    @city = City.find(@user.city_id)
    @nb_gossips = Gossip.where(user_id: @user.id).count
    @nb_comments = Comment.where(user_id: @user.id).count
    @gossips_arrray = Gossip.where(user_id: @user.id)
  end
  
  def new
  # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
  end
  
  def create
    @user = User.new(
      city_id: params[:ville],
      email: params[:email],
      password: params[:password],
      first_name: params[:first_name],
      last_name: params[:last_name],
      description: params[:description],
      age: params[:age])
    if @user.save
      redirect_to new_session_path
      flash.now[:success] = "Compte crée avec succès"
    else 
      render "new"
    end

  end
  
  def edit
  # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
  end
  
  def update
    # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params
    # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
  end
  
  def destroy
    # Méthode qui récupère le potin concerné et le détruit en base
    # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
  end

end
