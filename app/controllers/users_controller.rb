class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザーが登録されました."
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # 更新に成功した場合を扱う。
      flash[:success] = "ユーザー情報が更新されました．"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "退会しました．"
    redirect_to root_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :introduce, :password, :password_confirmation)
    end

    # beforeアクション



    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
        if !current_user?(@user) && !current_user.admin?
          redirect_to root_url
        end 
    end
end
