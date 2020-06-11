class UsersController < ApplicationController
  before_action :require_user_logged_in, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :likes]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(18)
  end

  def show
    @posts = @user.posts.order(id: :desc).page(params[:page]).per(18)
    counts(@user)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報を更新しました'
      redirect_to @user
    else
      flash[:danger] = '更新に失敗しました'
      render :edit
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザー登録しました'
      redirect_to @user
    else
      flash[:danger] = 'ユーザー登録に失敗しました'
      render :new
    end
  end
  
  def likes
    @likes = @user.fav_posts.page(params[:page]).per(18)
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_name)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
