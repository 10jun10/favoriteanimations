class ApplicationController < ActionController::Base

  include SessionsHelper

  private
  
  def require_user_logged_in
    unless  logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_posts = user.posts.count
    @count_likes = user.fav_posts.count
    # @counts_user = fav_posts.user.count
  end
  
  # def counts(post)
  #   @count_likes = post.users.count
  # end
end
