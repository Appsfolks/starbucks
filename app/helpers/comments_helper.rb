module CommentsHelper
  
  
  def delete_link(comment)
   return "/users/#{comment.user.cached_slug}/comments/#{comment.id}/delete"
  end
  
  def comment_like_link(comment)
   return "/users/#{comment.user.cached_slug}/comments/#{comment.id}/likecomment"
  end
  
  def user_comment?(comment)
    current_user.id == comment.user_id
  end

  
end
