class GosssipsController < ApplicationController

	before_action :set_gossip, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user, only: [:edit, :update, :destroy]

	#code de la methode private set_gossip qui va se derouler avant les methodes show, edit, update et destroy

  def index
	@gossips = Gosssip.all
	@gossips_likes = Like.gossips(current_user.id)
	#@likes = Like.where(user_id: current_user.id)

	# Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
  end

  def show
	@gossip = Gosssip.find(params[:id])
	@comments = Comment.where(gosssip: @gossip)
	@comment = Comment.new
	puts @like = Like.where(user_id: current_user.id, gosssip_id: @gossip)

	# Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
  end

  def new
	puts logged_in?
    	@gossip = Gosssip.new
		@tags = Tag.all
	  # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
  end

  def create
   	@gossip = Gosssip.new(gossip_params)
	@gossip.user = User.find_by(id: current_user.id)
	@gossip.tags = Tag.where(id: params[:tag_ids])

	if  @gossip.save
		redirect_to gosssips_path, flash: {success: "Gossip cree avec success" }

	else
		@tags = Tag.all
		render 'new'

	end
	  # Méthode qui créé un potin à partir du contenu du formulaire de new.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params (ton meilleur pote)
    # Une fois la création faite, on redirige généralement vers la méthode show (pour afficher le potin créé)
  end

  def edit
	  # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
  end

  def update
	  if @gossip.update(gossip_params)
 	 	flash[:success] = "Gossip modifie avec success"	
	 	redirect_to gosssip_path(@gossip.id)
	  else
		render 'edit'
	  end
		
		# Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params
    # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
  end

  def destroy
	  @gossip.destroy
          flash[:danger] = "Gossip supprime avec success" 

	  redirect_to gosssips_path
    # Méthode qui récupère le potin concerné et le détruit en base
    # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
  end

	private

	def gossip_params
		return params.require(:gosssip).permit(:title, :content)
	end
	
	def set_gossip
          @gossip = Gosssip.find(params[:id])
	end

	def authenticate_user
		unless current_user.id == @gossip.user.id
		  flash[:danger] = "Acces restreint"
		  redirect_to gosssips_path
		end
	  end

end
