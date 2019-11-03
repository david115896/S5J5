class UsersController < ApplicationController

  skip_before_action :only_signed_in, only: [:new, :create]


  def index
     @users = User.all
	
	# Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
  end

  def show
        @user = User.find(params[:id])
        @gossips_user = Gosssip.where(user: @user)
        @gossips_likes = Like.gossips(current_user.id)

	
	# Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
  end

  def new
	@user = User.new
      	
	# Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      redirect_to gosssips_path, flash: {success: "Bienvenue #{@user.first_name}" }
   
     else
        render 'new'
        #redirect_to new_session_path
     end

  end

  def edit
	@user = User.find(params[:id])
	
	# Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
  end

  def update
	@user = User.find(params[:id])
        @user.update(user_params)
	
	redirect_to user_path(@user.id)
    # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params
    # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
  end

  def destroy
        @user = User.find(params[:id])
	@user.destroy	

	redirect_to root_path
      	
      	# Méthode qui récupère le potin concerné et le détruit en base
    # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
  end

	private

	def user_params
		return params.require(:user).permit(:first_name, :city_id, :email, :password )
	end

end
