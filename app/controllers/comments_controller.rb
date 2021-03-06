class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@comment.post) }
        format.js
        # flash[:notice] = "Comment successfully added!"
      else
        format.html { render :new }
        format.html { render :errors }
      end
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = "Edit Successful!"
      redirect_to post_comment_path(@post, @comment)
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(@comment.post)
  end

  private
  def comment_params
    params.require(:comment).permit(:text)
  end

end
