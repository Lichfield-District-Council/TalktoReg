Admin.controllers :accounts do

  get :index do
    @accounts = Account.all
    render 'accounts/index'
  end

  get :new do
    @account = Account.new
    @councils = Council.all
    render 'accounts/new'
  end

  post :create do
    @account = Account.new(params[:account])
    if @account.save
      flash[:notice] = 'Account was successfully created.'
      redirect url(:accounts, :edit, :id => @account.id)
    else
      render 'accounts/new'
    end
  end

  get :edit, :with => :id do
  	redirect options.login_page if current_account.id != params[:id].to_i && current_account.role != "admin"
    @account = Account.find(params[:id])
    @councils = Council.all
    render 'accounts/edit'
  end

  put :update, :with => :id do
  	redirect options.login_page if current_account.id != params[:id].to_i && current_account.role != "admin"
    @account = Account.find(params[:id])
    if @account.update_attributes(params[:account])
      flash[:notice] = 'Account was successfully updated.'
      redirect url(:accounts, :edit, :id => @account.id)
    else
      render 'accounts/edit'
    end
  end

  delete :destroy, :with => :id do
    account = Account.find(params[:id])
    if account != current_account && account.destroy
      flash[:notice] = 'Account was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Account!'
    end
    redirect url(:accounts, :index)
  end
end
