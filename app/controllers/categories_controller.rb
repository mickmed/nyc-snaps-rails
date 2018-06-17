class CategoriesController < ApplicationController

  before_action :authenticate, except: [:index, :show]
 
 
 def authenticate
   @shoonga = authenticate_or_request_with_http_basic do |username, password|
     username == "4vght" && password == "we8vds"
   end
 end
  
  
 def index
   @photos = Photo.all 
   @cats = Category.where.not(id: 1)
   @categories = Category.all
   
 end
 
 def show
   @photos = Photo.all
   @cats = Category.all
   @category = Category.find(params[:id])
   #@items = @user.items.paginate(page: params[:page])
   #debugger
 end
     
  
  
  
  def new
    @photos = Photo.all
   @category = Category.new
   @cats = Category.where.not(id: 1)
  end
   
  def create
    
    @photos = Photo.all
    @cats = Category.where.not(id: 1)
   @category = Category.new(category_params)
   if params[:title].nil?
     if @category.save
       flash[:success] = "category created!"
       render 'edit'
     else
       redirect_to root_path
     end
   end
 end
   
   
 def edit
   @photos = Photo.all
   @cats = Category.where.not(id: 1)
   @category = Category.find(params[:id])
 end
 
 def update
   @category = Category.find(params[:id])
   if @category.update_attributes(category_params)
     # Handle a successful update.
     flash[:success] = "cat updated"
     redirect_to categories_path
   else
     render 'edit'
   end
 end
   
 def destroy
   @cats = Category.where.not(id: 1)
   Category.find(params[:id]).destroy
   flash[:success] = "photo deleted"
   redirect_to root_url
 end
 
 
 private
 
 def category_params
       params.require(:category).permit(:name)
     end
 
 end
 