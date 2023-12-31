class PrototypesController < ApplicationController

  before_action :authenticate_user! ,only: [:edit,:new,:destroy]
  before_action :editA, only: [:edit ]

  def index
    @prototypes = Prototype.all
    
  end

  def new

    @prototype= Prototype.new
    
  end

  def show

    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)


  end

  def edit

    @prototype = Prototype.find(params[:id])
    

  end

  def update
    @prototype = Prototype.find(params[:id])
  
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render 'prototypes/edit'
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    
    if @prototype.user == current_user
      @prototype.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end


  
  def create
    
     @prototype = Prototype.new(prototype_params)
      if @prototype.save

        redirect_to root_path
      else
        render :new
      end

  end

  private

  def prototype_params

    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id )
  end

  def editA
    @prototype = Prototype.find(params[:id])
    
    unless @prototype.user == current_user
      redirect_to root_path
    end
  end

  

  

end



