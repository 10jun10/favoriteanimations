class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :edit]
  before_action :set_post, only: [:edit, :show, :update]
  
  def index
    @posts = Post.order(id: :desc).page(params[:page]).per(18)
    # ランキング機能
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
    # @count_fav = post.
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿しました'
      redirect_to root_url
    else
      @posts = current_user.posts.order(id: :desc).page(params[:page]).per(18)
      flash.now[:danger] = '投稿に失敗しました'
      render 'toppages/index'
    end
  end
  
  def new
  end
  
  def edit
  end
  
  def show
  end
  
  def update
    if @post.update(post_params)
      flash[:success] = '更新しました'
      redirect_to @post
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    #@post = Post.find(params[:id])
    @post.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :comment, :image)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
  
  def set_post
    @post = Post.find(params[:id])
  end
end
