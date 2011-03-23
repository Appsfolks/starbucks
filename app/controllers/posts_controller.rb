class PostsController < ApplicationController
    before_filter :verify_credentials, :only => [:edit, :delete, :index] 
  def index
    @post = Post.new
    @post.post_content = 'Post something...'
    if params[:user_id].nil?
      @posts = Post.all
    else
      @user= User.find_by_cached_slug(params[:user_id])
      @posts = Post.where(:user_id=>@user.id).order('created_at DESC')
    end
  end
  
  def morecomments
     
     @post = Post.find(params[:id])
     @comments = Comment.where(:commentable_id=>@post.id).limit(2**32).offset(3)

        respond_to do |format|
                 format.html { redirect_to root_path }
                 format.js
        end
 
  end
  
  def new
    @post = Post.new
    
  end
  
  def create
      @post = Post.new(:post_content=>params[:post][:post_content], :user_id=>current_user.id, :likes=>0)
      
      respond_to do |format|
           if @post.save
             format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
             format.xml  { render :xml => @post, :status => :created, :location => @post }
             format.js
           
           else
             format.html { render :action => "new" }
             format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
             format.js { render :partial=>'shared/error', :locals=>{:obj=>@post} }
           end
         end
    
   end
   
   def likepost
       if Post.exists?(params[:id])
         logger.info 'post exists'
         @post = Post.find(params[:id] )
          @post.likes = @post.likes + 1
          if @post.save
            @post_like_count = @post.likes
          end
       end

          respond_to do |format|
                   format.html { redirect_to root_path }
                   format.js
          end
     
   end

end
