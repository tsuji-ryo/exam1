class BlogsController < ApplicationController
  before_action :set_blog, only: [:edit, :update, :destroy]
  
  def index
    @blogs = Blog.all
  end
  
  def new
    if params[:back]
    @blog = Blog.new(blogs_params)
    else
      @blog = Blog.new
    end
  end
  
  def create
    @blog = Blog.new(blogs_params)
    if @blog.save
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to blogs_path, notice: "ブログを作成しました！"
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end
  
  def edit
    @blog = Blog.find(params[:id])
  end
  
  def update
    @blog = Blog.find(params[:id])
    @blog.update(blogs_params)
    redirect_to blogs_path
  end
  
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path
  end
  
  def confirm
    @blog = Blog.new(blogs_params)
    render :new if @blog.invalid?
  end
  
  private
    def blogs_params
      params.require(:blog).permit(:title, :content)
    end
    
    def set_blog
      @blog = Blog.find(params[:id])
    end
end
