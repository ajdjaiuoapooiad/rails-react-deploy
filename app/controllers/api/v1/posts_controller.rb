class Api::V1::PostsController < ApplicationController
  def index
    # @posts = Post.all 
    # render json: @posts

    if  params[:category] == 'all'
      params[:category] = nil
    end
    if params[:income] == 'all'
        params[:income] = nil
    end
    if  params[:search] == ''
        params[:search] = nil
    end

    
    if params[:category] == nil && params[:income] == nil  && params[:search] == nil    # if no title is provided, return all posts;
      @posts = Post.all  # if no title is provided, return all posts
    elsif params[:search] != nil && params[:category] != nil && params[:income] != nil
      @search = params[:search] 
      @category = params[:category]
      @income = params[:income]
      @posts = Post.where('title LIKE ?', "%#{@search}%").where(category: @category).where(income: @income) # if title is provided, filter posts by title
    elsif  params[:search] != nil && params[:category] != nil && params[:income] == nil
      @search = params[:search] 
      @category = params[:category]
      @posts = Post.where('title LIKE ?', "%#{@search}%").where(category: @category)
    elsif params[:search] != nil && params[:category] == nil && params[:income] != nil
      @search = params[:search] 
      @income = params[:income]
      @posts = Post.where('title LIKE ?', "%#{@search}%").where(income: @income)
    elsif params[:search] == nil && params[:category] != nil && params[:income] != nil
      @category = params[:category] 
      @income = params[:income]
      @posts = Post.where(income: @income).where(category: @category)
    elsif params[:search] == nil && params[:category] == nil && params[:income] != nil
      @income = params[:income]
      @posts = Post.where(income: @income)
    elsif params[:search] == nil && params[:category] != nil && params[:income] == nil
      @category = params[:category]
      @posts = Post.where(category: @category)
    elsif params[:search] != nil && params[:category] == nil && params[:income] == nil
      @search = params[:search]
      @posts = Post.where('title LIKE ?', "%#{@search}%")
    end
    
    render json: @posts.order(id: "DESC")

  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: :created
      
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :category, :income)
  end

  
end