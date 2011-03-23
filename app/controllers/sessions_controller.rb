class SessionsController < ApplicationController
  include RestGraph::RailsUtil
  
  before_filter :filter_setup_rest_graph
  
  def new
    if logged_in?
      profile = Profile.find_by_user_id(current_user.id)
      
      redirect_to user_profile_path(current_user,profile)
    end
  end

  def signout
    
  reset_session
  current_user= nil
  
  redirect_to users_path
    
  end
  
  def fbsignin
     fb_object = rest_graph.get('me')
     if !fb_object["id"].nil?
       session[:fb_user_id] = fb_object["id"]
       session[:fb_name] = fb_object["name"]
       session[:fb_first_name] = fb_object["first_name"]
       session[:fb_last_name] = fb_object["last_name"]
       session[:fb_email] = fb_object["email"]
       create_or_update_user(fb_object["id"], fb_object["email"])
    else
      redirect_to login_path
    end
  end 
  
  def fbsignup
     fb_object = rest_graph.get('me')
     if !fb_object["id"].nil?
       session[:fb_user_id] = fb_object["id"]
       session[:fb_name] = fb_object["name"]
       session[:fb_first_name] = fb_object["first_name"]
       session[:fb_last_name] = fb_object["last_name"]
       session[:fb_email] = fb_object["email"]
    else
      redirect_to login_path
    end
  end
  
  def fbsignout
    
  end
     
  
  def create
    #retval = User.authenticate(params[:user_name], params[:password])
    #if retval
    #  current_user = User.find_by_name(params[:user_name])
    #else
     # current_user = nil
    #  redirect_to :url=>'users/new', :flash=>{:notice=>'User name or Paswword is incorrect'}
    #end
   username = params[:user_name]
   passwd = params[:password]

   user = User.authenticate(username, passwd)
    if !user.nil?
      session[:current_user_id] = user.id
      current_user=user
      profile = Profile.find_by_user_id(user.id)
      if profile.nil?
        flash[:notice] = 'Profile not created yet'
        redirect_to new_user_profile_path(user,profile)
      else
        if profile.first_name.blank? || profile.last_name.blank? || profile.birth_day.blank? 
          flash[:notice] = 'Profile not complete. Please complete your profile to proceed'
          redirect_to edit_user_profile_path(user,profile)
        else
          if(session[:lasturl].blank?)
            redirect_to users_path
          else
            redirect_to session[:lasturl]
          end
        end
      end
    else
      session[:current_user_id] = nil
      current_user=nil
      flash.now[:notice] = 'Username or Password is incorrect'
      render :action => 'new'
    end
  end
  
  private
  
  def filter_setup_rest_graph
        if fb_user?
          rest_graph_setup(:auto_authorize => true,:auto_authorize_scope   => 'email' )
        end
   end
   
   def self.create_or_update_user(fb_id, fb_email)
     if User.exists?(:fb_user_id => fb_user_id)
       current_user= User.where(:fb_user_id =>fb_id).first
     else
       if User.exists?(:email=>fb_email)
          user = User.where(:email=>fb_email).first
          user.fb_user_id = fb_id
          @user.save
        else
          user = User.new(params[:user])
          if user.save
              profile = Profile.new(:slug=>@user.cached_slug, :user_id=>@user.id, :first_name => session[:fb_first_name], 
                                     :last_name => session[:fb_last_name])
              profile.save
              
              redirect_to edit_user_profile_path(user,profile)
          end
       end
     end
   end
  
end
