class FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @favorite = current_user.favorites.new(book_id: @book.id)
    @favorite.save
    #redirect_back(fallback_location: root_path) 非同期だからコメントアウト済み
  end

  def destroy
    @book = Book.find(params[:book_id])
    @favorite = current_user.favorites.find_by(book_id: @book.id)
    @favorite.destroy
    #redirect_back(fallback_location: root_path) 非同期だからコメントアウト済み
  end
end
