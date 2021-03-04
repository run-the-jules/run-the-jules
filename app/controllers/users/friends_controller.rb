class Users::FriendsController < ApplicationController
  def index

    # needs to get most recent record for each friend -- backend endpoint?
    @friends = current_user.find_friends
  end

  def search
    friend = User.find(params[:query])

    if friend
      # hit backend endpoint to create follow relationship
      flash[:succes] = "You are now following #{friend.full_name}!"
      redirect_to user_friends_path(current_user)
    else
      flash[:error] = "User doesn't exist!"
      redirect_to user_friends_path(current_user)
    end
  end
end