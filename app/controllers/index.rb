get '/' do
  session[:destination] = "/"
  erb :index
end

get '/login' do
  erb :login
end

get '/signup' do
  erb :signup
end

post '/signup' do
  user = User.create(params[:user])
  session[:user_id] = user.id
  redirect to '/'
end

get '/logout' do
  session.clear
  redirect to '/'
end

post '/login' do
  if user = User.authenticate(params[:user])
    session[:user_id] = user.id
    redirect to "#{session[:destination]}"
  else
    redirect to '/login'
  end
end

get '/upload' do
  session[:destination] = "/upload"
  redirect '/login' unless current_user
  @user = current_user
  erb :upload_photo
end

post '/upload' do
	p params
  @album = Album.create(:album_name  =>  params[:album],
  					            :user  => current_user)

  photo = Photo.create(:file           => params[:image])
# NEED TO ASSOCIATE WITH AN ALBUM

  redirect to "/users/#{current_user.id}/albums"
end

get '/users' do
	@users = User.all
	erb :users
end

get '/photos' do
  @photos = Photo.all
  erb :photos
end

get '/users/:user_id/albums' do
	@albums = Album.find_all_by_user_id(params[:user_id])
	erb :albums
end

get '/albums/:album_id' do
	@photos = Photo.find_all_by_album_id(params[:album_id])
	erb :photos
end


