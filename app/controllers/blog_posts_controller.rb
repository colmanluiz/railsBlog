class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @blog_posts = BlogPost.all
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      flash[:success] = "BlogPost successfully created"
      redirect_to @blog_post
    else
      flash[:error] = "Something went wrong"
      render 'new', status: :unprocessable_entity
    end
  end

  def update
      if @blog_post.update(blog_post_params)
        flash[:success] = "BlogPost was successfully updated"
        redirect_to @blog_post
      else
        flash[:error] = "Something went wrong"
        render 'edit', status: :unprocessable_entity
      end
  end

  def destroy
    if @blog_post.destroy
      flash[:success] = 'BlogPost was successfully deleted.'
      redirect_to root_path
    else
      flash[:error] = 'Something went wrong'
      redirect_to blog_posts_url
    end
  end


  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body)
  end

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, flash: { error: "Record not found" }
  end
end
