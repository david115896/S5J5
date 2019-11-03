class CitiesController < ApplicationController

    before_action :set_city, only: [:show, :edit, :update, :destroy]

    def index
        @cities = City.all
     
     # Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
   end
 
   def show
        @gossips_city = Gosssip.joins(:user).where(:users => { :city => @city })
        @gossips_likes = Like.gossips(current_user.id)


        # puts @gossips_city = Gosssip.where(city: @city)
        
     # Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
   end
 
   def new
        @city = City.new
           
     # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
   end
 
   def create
     @city = City.create(city_params)
 
     redirect_to city.path(@city.id)
     # Méthode qui créé un potin à partir du contenu du formulaire de new.html.erb, soumis par l'utilisateur
     # pour info, le contenu de ce formulaire sera accessible dans le hash params (ton meilleur pote)
     # Une fois la création faite, on redirige généralement vers la méthode show (pour afficher le potin créé)
   end
 
   def edit
       
     # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
   end
 
   def update
        @city.update(city_params)
     
        redirect_to city_path(@city.id)
     # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
     # pour info, le contenu de ce formulaire sera accessible dans le hash params
     # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
   end
 
   def destroy
        @city.destroy
        flash[:danger] = "Ville supprimee avec success" 

            redirect_to root_path
           
           # Méthode qui récupère le potin concerné et le détruit en base
     # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
   end
 
     private
 
     def city_params
         return params.require(:city).permit(:name, :zip_code) 
     end

     def set_city
        @city = City.find(params[:id])
      end

end
