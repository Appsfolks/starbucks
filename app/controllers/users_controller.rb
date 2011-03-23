class UsersController < ApplicationController
  respond_to :html, :xml, :json
  before_filter :verify_credentials, :only => [:edit, :delete] 
  def index
    @users = User.all
    @profiles = Profile.all
  end
  
  def home
  end
  


  def new
    @user = User.new
    @mode = 'create'
  end
  
  def create
    @user = User.new(params[:user])
    if(@user.save)
      
      profile = Profile.new(:slug=>@user.cached_slug, :user_id=>@user.id)
      profile.save
      flash[:notice] = "User Succesfully created!"
      if(session[:last_url].nil?)
        redirect_to :action => "index" 
      else
        redirect_to session[:last_url]
      end
      
    else
      flash.now[:notice] = "User cannot be created!"
      render  :action=>'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
    @mode = 'edit'
  end
  

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      @mode= 'create'
      flash.now[:notice] = 'User updated succesfully'
      render :action=>'show'
    else
      flash.now[:notice] = 'User cannot be updated'
      @mode= 'edit'
      render :action=>'edit'
    end

    end
    
    def connect
      
       @user = User.find_by_cached_slug(params[:user_id])
       current_user.add_friend(@user)
        flash.now[:notice] = "Friend Request sent succesfully"
        respond_to do |format|
               format.html { redirect_to(current_user, :notice => "Friend Request sent succesfully") }
               format.xml  { render :xml => current_user, :status => :created, :location => @user }
               format.js
        end
    end 
    
     def accept

         @user = User.find_by_cached_slug(params[:user_id])
         current_user.accept_friend(@user)
          flash.now[:notice] = "Friend Request Accepted succesfully"
          respond_to do |format|
                 format.html { redirect_to(current_user, :notice => "Friend Request Accepted succesfully") }
                 format.xml  { render :xml => current_user, :status => :created, :location => @user }
                 format.js
          end
      end
    
    def disconnect

        @user = User.find_by_cached_slug(params[:user_id])
        current_user.remove_friend(@user)
         flash.now[:notice] = "Removed Friendship"
         respond_to do |format|
                format.html { redirect_to(current_user, :notice => 'Unfollowed!') }
                format.xml  { render :xml => @user, :status => :created, :location => @user }
                format.js
         end
     end
    

end
