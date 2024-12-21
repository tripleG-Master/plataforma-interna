class UsersController < ApplicationController
  before_action :authenticate_owner
  before_action :user_params, only: [:update]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update!(user_params)
      redirect_to user_path(@user), notice: "User updated successfully"
    else
      render :edit, alert: "Failed to update user"
    end
  end

  protected

  def user_params
    permitted_params = [:name, :email, :bio, :profile_picture]
    if params[:user][:password].present? || params[:user][:password_confirmation].present?
      permitted_params += [:password, :password_confirmation]
    end
    params.require(:user).permit(*permitted_params)
  end

end
