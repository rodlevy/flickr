class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many  :albums
  has_many  :photos, :through => :albums

   def self.create(params={})
    @user = User.new(:email => params[:email], 
    				 :name => params[:name],
    				 :password => 	params[:password])
    @user.save!
    @user
  end

   def self.authenticate(params)
    user = User.find_by_name(params[:name])
    (user && user.password == params[:password]) ? user : nil
  end

end
