class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :current_user, only: [:new, :edit, :show]

  def index
    @blogs = Blog.all
  end


  def show
     @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def new
    @blog = Blog.new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def edit
  end


  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id 
    @blog.image.retrieve_from_cache! params[:cache][:image]
    @blog.save!
    

    respond_to do |format|
      if @blog.save
        ContactMailer.contact_mail(@blog).deliver
        format.html { redirect_to @blog, notice: '投稿しました' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: '投稿しました' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: '投稿を削除しました' }
      format.json { head :no_content }
    end
  end
  
   def confirm
    @blog = Blog.new(blog_params)
   end

  private
    def set_blog
      @blog = Blog.find(params[:id])
    end

    def blog_params
      params.require(:blog).permit(:content, :image)
    end
end