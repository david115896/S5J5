class LikesController < ApplicationController

  before_action :find_gossip


  # POST /likes
  # POST /likes.json
  def create
    if already_liked?
      flash[:danger] = "You can't like more than once"
    else
      @gossip.likes.create(user_id: current_user.id)
    end
    redirect_to gosssips_path

  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    find_like
    @like.destroy
     redirect_to gosssip_path(@gossip.id)
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.


    def already_liked?
      Like.where(user_id: current_user.id, gosssip_id: params[:gosssip_id]).exists?
    end

    def find_gossip
      @gossip = Gosssip.find(params[:gosssip_id])
    end

    def find_like
       @like = Like.where(user_id: current_user.id, gosssip_id: params[:gosssip_id]).first
      
   end

    # Never trust parapmeters from the scary internet, only allow the white list through.
  
end
