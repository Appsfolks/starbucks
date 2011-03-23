require 'digest/sha2'
class ApplicationController < ActionController::Base
  protect_from_forgery

  include LoginHelper
  
  def verify_credentials
     if current_user.nil?
       flash[:notice] = 'Please login'
       session[:lasturl] = request.request_uri
       redirect_to login_path
     end
   end
   
   def fb_user?
      !session[:fb_user_id].nil?
    end

  
end
