module PostsHelper
  

   def post_like_link(post)
     return "/users/#{post.user.cached_slug}/posts/#{post.id}/likepost"
    end

    def more_comments_link(post)
      return "/users/#{post.user.cached_slug}/posts/#{post.id}/morecomments"
     end

   
   
   
end
