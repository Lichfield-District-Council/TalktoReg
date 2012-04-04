Admin.controllers :contacts do

  get :index do
    @contacts = Contacts.all
    render 'contacts/index'
  end

  get :new do
  	@categories = Categories.all
  	@councils = Council.all
    @contacts = Contacts.new
    render 'contacts/new'
  end

  post :create do
    @contacts = Contacts.new(params[:contacts])
    if @contacts.save
      flash[:notice] = 'Contacts was successfully created.'
      redirect url(:contacts, :edit, :id => @contacts.id)
    else
      render 'contacts/new'
    end
  end

  get :edit, :with => :id do
    @contacts = Contacts.find(params[:id])
    @categories = Categories.all
    @councils = Council.all
    render 'contacts/edit'
  end

  put :update, :with => :id do
    @contacts = Contacts.find(params[:id])
    if @contacts.update_attributes(params[:contacts])
      flash[:notice] = 'Contacts was successfully updated.'
      redirect url(:contacts, :edit, :id => @contacts.id)
    else
      render 'contacts/edit'
    end
  end

  delete :destroy, :with => :id do
    contacts = Contacts.find(params[:id])
    if contacts.destroy
      flash[:notice] = 'Contacts was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Contacts!'
    end
    redirect url(:contacts, :index)
  end
end
