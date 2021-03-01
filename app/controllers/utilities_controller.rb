class UtilitiesController < ApplicationController
  def index
    email = current_user.email
    utility = params[:provider]
    data = UsersService.new_user_utility(email, utility)[:data].first
    redirect_to data[:attributes][:url]
  end
end
