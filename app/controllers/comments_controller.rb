class CommentsController < ApplicationController

  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:edit, :update, :destroy]


  # GET /comments
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  def show

  end

  # GET /comments/new
 

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
   # @gossip = Gosssip.find(@comment.gosssip_id)
  end

  # POST /comments
  def create

    @comment = Comment.new(comment_params)
    @comment.gosssip_id = params[:gossip]
    @comment.user_id = current_user.id
       
      if @comment.save
        redirect_to gosssip_path(params[:gossip]), flash: {success: " Commentaire ajoute" }
      else
       redirect_to gosssip_path(params[:gossip]), flash: {danger: " Les commentaires ne peuvent pas avoir de caracteres speciaux" }

      end
    
  end

  # PATCH/PUT /comments/1
  def update

    if @comment.update(comment_params)
      redirect_to gosssip_path(@comment.gosssip_id), flash: {success: " Commentaire modifie" }
    else
      render 'edit'
    end
    
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
      redirect_to gosssips_path, flash: {success: " Le commentaire a ete detruit" }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      return params.require(:comment).permit(:content)
    end

    def authenticate_user
      unless current_user.id == @comment.user_id 
        flash[:danger] = "Acces restreint"
        redirect_to gosssips_path
      end
      end
end
