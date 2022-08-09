class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
    @book_comment = BookComment.new
    # unless ViewCount.find_by(user_id: current_user.id, book_id: @book.id) 一人につき閲覧一回のみカウントの場合
      current_user.view_counts.create(book_id: @book.id)
    # end
  end

  def index
    @books = Book.last_week_favorite_rank
    @book = Book.new
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.user == current_user
      @book.destroy
      flash[:notice] = "Book was successfully destroyed."
      redirect_to books_path
    else
      render :index
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end