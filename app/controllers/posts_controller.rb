class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save(post_params)
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @comments = @post.comments
  end

  private
  def post_params
    params.require(:post).permit(:text)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
