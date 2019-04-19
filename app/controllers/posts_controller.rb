class PostsController < ApplicationController
  before_action :set_target_post, only: %i[show edit update destroy]
  def index
    @posts = Post.page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      flash[:notice] = "「#{post.title}」の記事が投稿されました!"
      redirect_to posts_path
    else
      redirect_to new_post_path, flash: {
      post: post,
      error_messages: post.errors.full_messages
    }
    end
  end

  def show
     @comment = Comment.new(post_id: @post.id)
  end

  def edit
  end

  def update
    @post.update(post_params)
    if post.save
      redirect_to post
    else
      redirect_to edit_post_path(post.id)
    end
  end

  def destroy
    @post.delete
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:name, :title, :content)
  end

  def set_target_post
    @post = Post.find(params[:id])
  end
end
