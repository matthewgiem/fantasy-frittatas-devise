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
    respond_to do |format|
      if @post.save(post_params)
        format.html { redirect_to posts_path }
        format.js
      else
        format.html { render :new }
        format.js { render :errors }
      end
    end
  end

  def show
    # @old =  Time.now.minus_with_coercion(@comment.created_at)./60.round
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
