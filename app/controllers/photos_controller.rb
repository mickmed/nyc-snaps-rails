class PhotosController < ApplicationController
    before_action :authenticate, except: [:index, :show]
    impressionist :actions=>[:index, :show]
    # impressionist :actions=>[:index, :show], :unique => [:session_hash, :impressionable_id]
    before_action :set_page, only: [:index]
    PHOTOS_PER_PAGE = 6
    
    def index
      if params[:category]
        @category = params[:category] 
      else
        @category = 'favorites'
      end

      @cat_names = Category.pluck(:name)
      @photosperpage = PHOTOS_PER_PAGE     
      @photos_count = Photo.all.count
      
      
        if @page.to_i > (@photos_count.to_f/@photosperpage).ceil
          @page = @page - 1
        end 
      
      if @category == 'favorites'
        @photos = Photo.all.joins(:impressions).group('photos.id').order('count(photos.id) desc').limit(PHOTOS_PER_PAGE).offset((@page-1) * PHOTOS_PER_PAGE)
        @photos_all_in_category = Photo.all.joins(:impressions).group('photos.id').order('count(photos.id) desc').limit(12)
        
      end        
      
      if @category == 'newest'
        @photos = Photo.all.includes(:categories).order('date_taken desc').limit(PHOTOS_PER_PAGE).offset((@page-1) * PHOTOS_PER_PAGE)
        @photos_all_in_category = Photo.all.order('date_taken desc').limit(12)
      end
      
      if @category !=  'favorites' && params[:category] != 'newest'
        @photos = Photo.where(categories: {name: params[:category]}).includes(:categories).limit(PHOTOS_PER_PAGE).offset((@page-1) * PHOTOS_PER_PAGE) 
        @photos_all_in_category = Photo.where(categories: {name: params[:category]}).includes(:categories)
      end
      @photos_counts = Hash.new 0
      @photos_all_in_category.each do |photo|
        @photos_counts[photo] += 1
      end
      @ogimage = @photos.shuffle[1]
      
      session[:photo_flick] = @photos_all_in_category
      session[:category] = @category

    end


    def show

      @photo = Photo.find(params[:id]) 
      @photos_all_in_category = session[:photo_flick]
      @category = session[:category]
      @count = Impression.where("action_name = 'index'").count
   
      @photos_all_in_category.each_with_index do |photo, index|
        if @photo.id == photo["id"]
          @index = index.to_i
        end
      end
     
        @next = @photos_all_in_category[(@index)+1]
        @prev = @photos_all_in_category[(@index)-1]
    
      if (@next == NIL) 
        # @test = 'here';
        @next = @photos_all_in_category[0]
          
      end
      @ogimage = rails_blob_url(@photo.image)
    end
    
    def new
      @photo = Photo.new
      @categories = Category.all
    end
    
    def create
      @photo = Photo.new(photo_params)
      @photo.image.attach(params[:photo][:image])
      if @photo.save
        flash[:info] = "saved"
        redirect_to root_path
      else
        render 'new'
      end
    end
    
    def edit
      @photo = Photo.find(params[:id])
    end
    
    def update
      @photo = Photo.find(params[:id])
      if @photo.update_attributes(photo_params)
        # Handle a successful update.
        flash[:success] = "Photo updated"
        redirect_to photo_path
      else
        render 'edit'
      end
    end
    
    def destroy
      @photo = Photo.find(params[:id])
      @photo.image.purge 
      @photo.destroy
      flash[:success] = "photo deleted"
      redirect_to root_path
    end
  
  
  private

  def set_page
    if params[:page]
      if params[:page].to_i >= 1
        @page = params[:page].to_i 
      end 
      if params[:page].to_i == 0
        @page = 1 
      end 
    else
        @page = 1;
    end
  end

  def photo_params
    params.require(:photo).permit(:title, :description, :picture, :date_taken, category_ids:[])
  end
  
  def authenticate
    @shoonga = authenticate_or_request_with_http_basic do |username, password|
        username == "we8vds" && password == "4vght"
    end
  end
end 
