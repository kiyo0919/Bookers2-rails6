class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
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
