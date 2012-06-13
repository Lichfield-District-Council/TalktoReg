Admin.controllers :subcategories do

  get :index do
    @subcategories = Subcategory.all
    render 'subcategories/index'
  end

  get :new do
    @subcategory = Subcategory.new
    render 'subcategories/new'
  end

  post :create do
    @subcategory = Subcategory.new(params[:subcategory])
    if @subcategory.save
      flash[:notice] = 'Subcategory was successfully created.'
      redirect url(:subcategories, :edit, :id => @subcategory.id)
    else
      render 'subcategories/new'
    end
  end

  get :edit, :with => :id do
    @subcategory = Subcategory.find(params[:id])
    render 'subcategories/edit'
  end

  put :update, :with => :id do
    @subcategory = Subcategory.find(params[:id])
    if @subcategory.update_attributes(params[:subcategory])
      flash[:notice] = 'Subcategory was successfully updated.'
      redirect url(:subcategories, :edit, :id => @subcategory.id)
    else
      render 'subcategories/edit'
    end
  end

  delete :destroy, :with => :id do
    subcategory = Subcategory.find(params[:id])
    if subcategory.destroy
      flash[:notice] = 'Subcategory was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Subcategory!'
    end
    redirect url(:subcategories, :index)
  end
end
