class ArticlesController < ApplicationController
  def home
    @article = Article.last
  end
  def index
    @articles = Article.all
  end
  def new
    @article = Article.new
  end

  def create
    #render plain: params[:article].inspect
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article)
      flash[:notice] = "Tu Articulo fue salvado con exito!!"
    else
      render "new"
    end
  end
  def show
    @article = Article.find(params[:id])

  end
  def edit
  end
  def update
    if @article.update(article_params)
      flash[:notice] = "Tu Articulo fue Actualizado con exito!!"
      redirect_to article_path(@article)
    else
      render "edit"
    end
  end
  def destroy
    @article.destroy
    flash[:notice] = "Articulo eliminado con exito!!"
    redirect_to articles_path

  end
  private

  def set_article
    @article = Article.find(params[:id])
  end
  def article_params
    params.require(:article).permit(:title, :text, commenter:[])
  end
  def require_same_user
    if current_user != @article.user and !current_user.admin?   #Verifica si el usuario es el mismo y si es admin
      flash[:denger] = "Solo puedes editar o eliminar tus propios articulos!"
      redirect_to root_path
    end
  end

end
