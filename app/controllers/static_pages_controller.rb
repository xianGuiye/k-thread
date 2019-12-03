class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.microposts.build if logged_in?
    @feed_items = current_user.feed.paginate(page: params[:page]) if logged_in?
    @thread_items = Topic.all.paginate(page: params[:page])
  end

  def help
  end

  def about
  end


end
