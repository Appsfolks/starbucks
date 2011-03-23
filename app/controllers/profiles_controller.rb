include LoginHelper
class ProfilesController < ApplicationController
  layout 'profile'
  
  before_filter :verify_credentials, :only => [:edit, :delete] 
  def new
    @profile = Profile.new
  end

  def show
   @user = User.find_by_cached_slug(params[:user_id])
   @profile = Profile.find_by_user_id(@user.id)
  
   logger.info " params[user_id] = #{params[:user_id]} "
    logger.info "session[:current_user_id] = #{session[:current_user_id]} "
    @showEditLinks = valid_user?(@user.id)
  end

  def edit
     @profile = Profile.find_by_user_id(current_user.id)
  end

   def update
     @profile = Profile.find(params[:id])
     @user = current_user
     if @profile.update_attributes(params[:profile])
       flash[:notice] = 'Profile updated succesfully'
       redirect_to user_profile_path(@user,@profile)
     else
       flash.now[:notice] = 'Profile cannot be updated at this time'
       render :action=>'edit'
     end
   end

end
