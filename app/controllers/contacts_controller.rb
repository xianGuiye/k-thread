class ContactsController < ApplicationController
  def index
    @contacts = Contact.paginate(page: params[:page])
  end

  def new
    if logged_in?
      @contact = Contact.new(user_id: current_user.id)
      if current_user.admin?
        redirect_to contacts_path
      end
      else
      logged_in_user
    end
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.update_attribute(:user_id, current_user.id)
    if @contact.save
      flash[:success] = "お問い合わせを承りました．"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:title, :content)
  end
end
