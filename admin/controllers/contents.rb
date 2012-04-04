Admin.controllers :contents do

  get :index do
    @contents = Content.all
    render 'contents/index'
  end

  get :new do
  	@categories = Categories.all
  	@councils = Council.all
    @content = Content.new
    render 'contents/new'
  end

  post :create do
    @content = Content.new(params[:content])
    if @content.save
      flash[:notice] = 'Content was successfully created.'
      redirect url(:contents, :edit, :id => @content.id)
    else
      render 'contents/new'
    end
  end

  get :edit, :with => :id do
  	@categories = Categories.all
  	@councils = Council.all
    @content = Content.find(params[:id])
    render 'contents/edit'
  end

  put :update, :with => :id do
    @content = Content.find(params[:id])
    if @content.update_attributes(params[:content])
      flash[:notice] = 'Content was successfully updated.'
      redirect url(:contents, :edit, :id => @content.id)
    else
      render 'contents/edit'
    end
  end

  delete :destroy, :with => :id do
    content = Content.find(params[:id])
    if content.destroy
      flash[:notice] = 'Content was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Content!'
    end
    redirect url(:contents, :index)
  end
end
