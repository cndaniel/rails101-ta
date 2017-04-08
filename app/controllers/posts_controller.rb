class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_group_and_posts, except: [:index, :new, :create]
  def new
    @group = Group.find(params[:group_id])

    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.user = current_user
    @post.group = @group

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit

  end

  def update

    if @post.update(post_params)
      redirect_to group_path(@group),notice:"sucess"
    else
      render :edit
    end
  end

  def destroy

      @post.destroy
      redirect_to group_path(@group), alert:"deleted !"


  end




  private
    def post_params
      params.require(:post).permit(:content)
    end

    def find_group_and_posts
      @group = Group.find(params[:group_id])
      @post = Post.find(params[:id])

    end
end
