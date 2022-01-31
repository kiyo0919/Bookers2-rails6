class BookCommentsController < ApplicationController
  
  def create
    @book = Book.find(params[:book_id])#ビューのlink_toで指定してるURLの引数に特定のbookを指定している。従って、ルーティングでネストされているからbook_idには特定のbookのidが入っている。ネストはrails routesで確認できる。
    @comment = BookComment.new(book_comment_params)
    @comment.user_id = current_user.id
    @comment.book_id = @book.id
    @comment.save
    #redirect_to book_path(book) 非同期によってコメントアウト済み
  end

  def destroy
    @book = Book.find(params[:book_id])
    @comment = BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    #redirect_to book_path(params[:book_id]) 非同期によってコメントアウト済み
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
