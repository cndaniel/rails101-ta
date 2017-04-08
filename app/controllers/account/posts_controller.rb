class Account::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user_post, except: :index


  def index
    @posts = current_user.posts

  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    if @post.update(post_params)
      redirect_to account_posts_path
    else
      render :edit
    end

  end

  def destroy
    @post.destroy
      render :back, alert:" Success."

  end


  protected
  def find_user_post
    @post = current_user.posts.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:content)

  end


end
