class User < ActiveRecord::Base
  has_one :profile, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  
  has_many :comments, :dependent => :destroy
  
  has_many :events, :dependent => :destroy
  
 has_many :friendships, :dependent => :destroy
 
  
  has_many :friends, :through => :friendships, :conditions => "friendships.status = 'ACCEPTED'"
  
  
  has_many :requested_friends, :through => :friendships, :source => :friend, :conditions => "friendships.status = 'REQUESTED'", :order => "friendships.created_at"
  has_many :pending_friends, :through => :friendships, :source => :friend, :conditions => "friendships.status = 'PENDING'", :order => "friendships.created_at"

  
  
  has_friendly_id :name, :use_slug => true
  
  attr_accessor  :password
  attr_accessible :name, :email, :password
  validates_presence_of :name,  :message => "User name cannot be blank"
  validates_presence_of :email,  :message => "Email cannot be blank"
  validates_uniqueness_of :name, :message => "User name is already taken"
  validates_uniqueness_of :email, :message => 'Email already exists'
  validates_presence_of :password, :message => "Password cannot be blank"
  validates_confirmation_of :password, :message => "Password does not match"
  validates_format_of :email, :with => /([a-z0-9_.-]+)@([a-z0-9-]+)\.[a-z.]+/i, :message => "Email Address is invalid"
  
  before_save :encrypt_password
  
  before_save :create_profile 
  
  after_save :insert_profile
  
  def has_password?(submitted_password)
     #compare the encrypted version of the submitted password with the encrypted password in the db
     password_hash == encrypt(submitted_password)
   end
   
  def self.authenticate(username,passwd)
  
    user = User.find_by_name(username)
    if(user.nil?)
      nil
    else
        if user.has_password?(passwd)
          user
        else
          nil
        end
        
    end
    
  end
  
  def is_friend?(frienduser)
    Friendship.exists?(:user_id=>self.id, :friend_id=>frienduser.id, :status=>'ACCEPTED') || Friendship.exists?(:user_id=>frienduser.id, :friend_id=>self.id, :status=>'ACCEPTED')
  end
  
  
  def add_friend(frienduser)
    unless is_friend?(frienduser)
      friendship = Friendship.new(:user_id=>self.id, :friend_id=>frienduser.id,:status=>'REQUESTED')
      friendship.save   
      friendship2 = Friendship.new(:user_id=> frienduser.id, :friend_id => self.id, :status=>'PENDING')  
      friendship2.save
    end
  end
  
  
  def remove_friend(frienduser)
      if Friendship.exists(:user_id=>self.id,:friend_id=>frienduser.id,:status=>'ACCEPTED')
         Friendship.where(:user_id=>self.id,:friend_id=>frienduser.id,:status=>'ACCEPTED').first.destroy
      end
      
       if Friendship.exists(:user_id=>frienduser.id,:friend_id=>self.id,:status=>'ACCEPTED')
         Friendship.where(:user_id=>frienduser.id,:friend_id=>self.id,:status=>'ACCEPTED').first.destroy
      end
  end
  
  def accept_friend(frienduser)
    if frienduser.requested_friends.include?(self)
      friendship = Friendship.where(:user_id=>frienduser.id, :friend_id=>self.id, :status=>'REQUESTED').first
      friendship.status = 'ACCEPTED'
      friendship.save
      
      friendship2 = Friendship.where(:user_id => self.id, :friend_id=>frienduser.id, :status=>'PENDING').first
      friendship2.status = 'ACCEPTED'
      friendship2.save
    end
  end
  
  def ignore_friend(frienduser)
   if frienduser.requested_friends.include?(self)
      friendship = Friendship.where(:user_id=>frienduser.id,:friend_id=>self.id,:status=>'REQUESTED').first
      friendship.destroy
      friendship.save
      
      friendship = Friendship.where(:user_id=>self.id,:friend_id=>frienduser.id,:status=>'PENDING').first
      friendship.destroy
      friendship.save
      
    end
  end
      
  
  private
  
     def create_profile
       if new_record?
         @profile = Profile.new
         @profile.user_id = self
         @newrec = true
       else
         @newrec = false
         
       end
     end
     
     def insert_profile
       if @newrec
         @profile.save
       end
     end
         

     def encrypt_password
       self.salt = make_salt if new_record?
       self.password_hash = encrypt(password)
     end

     def encrypt(pwd)
       secure_hash("#{salt}--#{pwd}")
     end

     def make_salt
       secure_hash("#{Time.now.utc}--#{password}")
     end

     def secure_hash(hashstr)
       Digest::SHA2.hexdigest(hashstr)
     end
  
end
