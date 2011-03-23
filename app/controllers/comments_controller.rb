class CommentsController < ApplicationController
    before_filter :verify_credentials, :only => [:edit, :likes] 
  def new
    
  end

  def index
    
  end
  
  
  def likecomment
    
    if Comment.exists?(params[:id])
      logger.info 'comment exists'
      @comment = Comment.find(params[:id] )
       @comment.likes = @comment.likes + 1
       if @comment.save
         @comment_like_count = @comment.likes
       end
    end

       respond_to do |format|
                format.html { redirect_to root_path }
                format.js
       end

     end
  
  def create
    logger.info 'commentable_id:' + params[:comment][:commentable_id]
    @post = Post.find(params[:comment][:commentable_id])
    if current_user.nil?
      logger.info 'oh no..no current user!'
    end
    logger.info 'current_user_id: ' 
    @comment = Comment.build_from(@post, current_user.id, params[:comment][:body] )

     respond_to do |format|
           if @comment.save
             @comments = @post.comment_threads
             @comment_count = @comments.length
             format.html { redirect_to(@comment, :notice => 'Post was successfully created.') }
             format.xml  { render :xml => @comment, :status => :created, :location => @comment }
             format.js
           
           else
             format.html { render :action => "new" }
             format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
             format.js { render :partial=>'shared/error', :locals=>{:obj=>@comment} }
           end
         end
   
   end
   
   def deletecomment
    
     @comment = Comment.find(params[:id] )
     @post = Post.find(@comment.commentable_id)
    @comment_item = "comment_#{@comment.id}"
     if @comment.destroy
       @comment_count = @post.comment_threads.count
       @comments = @post.comment_threads
     end
     
     respond_to do |format|
              format.html { redirect_to root_path }
              format.js
     end
     
   end

end
