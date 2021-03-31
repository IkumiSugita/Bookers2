class BooksController < ApplicationController
  def index
    @book = current_user
    @books = Book.all
    @newbook = Book.new
  end
  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@newbook)
    else
      @books = Book.all
      @book = current_user
      render :index
    end
  end
  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @books = Book.all
    @newbook = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end

  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
     flash[:notice] = "You have updated book successfully."
     redirect_to book_path(@book.id)
    else
      render :edit
    end

  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path

  end


  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

end


