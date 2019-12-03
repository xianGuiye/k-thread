class TopicsController < ApplicationController
  before_action :admin_user,     only: [:edit, :update, :destroy]

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      flash[:success] = "掲示板を作成しました"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @topic_id = params[:id]
    @topic = Topic.find(@topic_id)
    @number = params[:number]
    @micropost = current_user.microposts.build(topic_id: @topic.id) 
    @page = params[:page]
    @microposts = @topic.microposts.paginate(page: @page)
    
  end

  def reply
    @topic = Topic.find(params[:id])
    @micropost = current_user.microposts.build(topic_id: @topic.id, reply: params[:number]) 
    @microposts = @topic.microposts.paginate(page: params[:page])
    render 'show'
  end

  def index
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(topic_params)
      # 更新に成功した場合を扱う。
      flash[:success] = "掲示板を更新しました"
      redirect_to @topic
    else
      render 'edit'
    end
  end

  def destroy
    Topic.find(params[:id]).destroy
    flash[:success] = "掲示板を削除しました"
    redirect_to root_url
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :category)
  end
end
