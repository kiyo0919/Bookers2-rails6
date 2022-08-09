class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @book_count = [@books.where(created_at: Time.zone.now.all_day).count]
    @days = ["今日"]
    for num in 1..6 do
      @book_count.push(@books.where(created_at: num.day.ago.all_day).count)
      @days.push("#{num}日前")
    end
    @current_user_entries = Entry.where(user_id: current_user.id)
    @user_entries =Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_user_entries.each do |current_user_entry|
        @user_entries.each do |user_entry|
          if current_user_entry.room_id == user_entry.room_id
            @is_room = true
            @room = current_user_entry.room
          end
        end
      end
      if not @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
    @today_books =  @books.created_today
    @yesterday_books = @books.created_yesterday
    @this_week_books = @books.created_this_week
    @last_week_books = @books.created_last_week
  end

    def index
      @users = User.all
      @user = current_user
      @book = Book.new
    end

    def edit
      @user = User.find(params[:id])
      if @user != current_user
        redirect_to user_path(current_user)
      end
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:notice] = 'Your profile was successfully updated.'
        redirect_to user_path(@user.id)
      else
        render :edit
      end
    end

    def followings
      @user = User.find(params[:id])
    end
  
    def followers
      @user = User.find(params[:id])
    end

    private

    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end

end
