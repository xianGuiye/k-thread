class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @topic = Topic.find(@micropost.topic_id)
    if @micropost.save
      flash[:success] = "メッセージが投稿されました."
      redirect_to @topic
    else
      #@feed_items = []
      #@thread_items = []
      @micropost = current_user.microposts.build(topic_id: @topic.id) 
      @microposts = @topic.microposts.paginate(page: params[:page])
      render @topic
    end
  end

  def destroy
    Micropost.find(params[:id]).destroy
    flash[:success] = "メッセージが削除されました．"
    redirect_to request.referrer || root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture, :topic_id, :reply)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil? && !current_user.admin? && !current_user?(@user)
    end
  
end