class Talktoregnew < Padrino::Application
  register LessInitializer
  use ActiveRecord::ConnectionAdapters::ConnectionManagement
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers
  
  layout :application

  enable :sessions
  
  disable :raise_errors
  disable :show_exceptions
  
  not_found do 
  	render '404', :layout => :application
  end
  
  error do
  	render '500', :layout => :application
  end
  
  get "/" do
  	render 'index', :layout => :page
  end
  
  get "/about" do
  	snacs = Contacts.select('DISTINCT snac')
  	@councils = []
  	
  	snacs.each do |snac|
  		@councils << Council.find_by_snac(snac.snac)
  	end
  	
  	render 'about'
  end
  
  get "/contact" do
  	render 'contact', :layout => :page
  end
  
  get "/mobile" do
  	render 'mobile', :layout => :page
  end
  
  get "/search", :provides => [:html, :json, :xml] do
  	require 'mapit'
  	
  	 if params[:postcode]
	  	@councils = Mapit.GetPostcode(params[:postcode])
	 elsif params[:lat]
	 	@councils = Mapit.GetLatlng(params[:lat], params[:lng])
	 end
	 
	 if @councils["error"]
	 	@postcode = params[:postcode]
	 	render 'error'
	 	
	 else
	 
		 allcats = Categories.all
		 @categories = []
		 @contacts = Array.new
		 @subcategories = Array.new
		 @count = 0

	     councildetails = Council.find_by_snac(@councils["council"]["id"])
	 	 @councils["council"]["email"] = councildetails.email
	 	 @councils["council"]["tel"] = councildetails.tel
	 	 @councils["council"]["website"] = councildetails.website
	 	 @councils["council"]["contacturl"] = councildetails.contacturl
		 
		 if @councils.include? 'county'
		 	countydetails = Council.find_by_snac(@councils["county"]["id"])
		 	@councils["county"]["email"] = countydetails.email
		 	@councils["county"]["tel"] = countydetails.tel
		 	@councils["county"]["website"] = countydetails.website
		 	@councils["county"]["contacturl"] = countydetails.contacturl
		 end
		 
		 allcats.each do |category|
		 	contacts = Contacts.where(:category_id => category.id, :subcategory_id => nil, :snac => @councils["council"]["id"])
		 	
		 	if contacts.count > 0
		 		@categories << category
			 	@contacts[category.id] = Array.new
			 	@count += 1
			 	
			 	contacts.each do |contact|
			 		if contact.name.length == 0
			 			contact.name = "Contact"
			 		end
					@contacts[category.id] << contact
			 	end
		 	end
		 end
		 
	  	case content_type
			when :html then
				if @count > 0
					render 'search.haml'
				else
					render 'sorry.haml', :layout => :page
				end
			when :json then
				render 'search.jsonify'
			when :xml then
				render 'search.builder'
			end
  	end
  end

  ##
  # Caching support
  #
  # register Padrino::Cache
  # enable :caching
  #
  # You can customize caching store engines:
  #
  #   set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', :exception_retry_limit => 1))
  #   set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1))
  #   set :cache, Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))
  #   set :cache, Padrino::Cache::Store::Memory.new(50)
  #   set :cache, Padrino::Cache::Store::File.new(Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
  #

  ##
  # Application configuration options
  #
  # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
  # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
  # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
  # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
  # set :public_folder, "foo/bar" # Location for static assets (default root/public)
  # set :reload, false            # Reload application files (default in development)
  # set :default_builder, "foo"   # Set a custom form builder (default 'StandardFormBuilder')
  # set :locale_path, "bar"       # Set path for I18n translations (default your_app/locales)
  # disable :sessions             # Disabled sessions by default (enable if needed)
  # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
  # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
  #

  ##
  # You can configure for a specified environment like:
  #
  #   configure :development do
  #     set :foo, :bar
  #     disable :asset_stamp # no asset timestamping for dev
  #   end
  #

  ##
  # You can manage errors like:
  #
  #   error 404 do
  #     render 'errors/404'
  #   end
  #
  #   error 505 do
  #     render 'errors/505'
  #   end
  #
end
