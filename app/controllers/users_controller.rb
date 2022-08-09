class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
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
