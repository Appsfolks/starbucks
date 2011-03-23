module LoginHelper
 
  def logged_in?
      !session[:current_user_id].blank?
    end

    def valid_user?(usr)
      logged_in? && (session[:current_user_id].to_s == usr.to_s)
    end

    def current_user
      if logged_in?
         @current_user =  User.find(session[:current_user_id]) 
       else
         @current_user = nil
       end
    end

    def current_user=(val)
      @current_user = val
    end

   def is_friend_of?(user)
     Friendship.exists?(:user_id=>current_user.id, :friend_id=>user.id, :status=>'ACCEPTED') || Friendship.exists?(:user_id=>user.id, :friend_id=>current_user.id,:status=>'ACCEPTED')
   end

   def is_request_pending?(user)
    Friendship.exists?(:user_id=>current_user.id, :friend_id=>user.id, :status=>'REQUESTED') 
   end

   def is_accept_pending?(user)
    Friendship.exists?(:user_id=>user.id, :friend_id=>current_user.id, :status=>'REQUESTED') 
   end

   def user_home_link(user)
     return "/users/#{user.cached_slug}/posts"
   end

   def its_me?(user)
     current_user == user 
   end



  

  
end