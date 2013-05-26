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
  erb :upload_photo
end

post '/upload' do
	p params
  album = Album.create(:album_name  =>  params[:album],
  					   :user  => current_user)

  photo = Photo.create(:photo_name      => params[:photo_name],
                         :album  =>  album.id,
                         :image     => params[:image])

  redirect to "/users/#{current_user.id}/albums"
end

get '/users' do
	@users = User.all
	erb :users
end

get '/users/:user_id/albums' do
	@albums = Album.find_all_by_user_id(params[:user_id])
	erb :albums
end

get '/albums/:album_id' do
	@photos = Photo.find_all_by_album_id(params[:album_id])
	erb :photos
end


# get '/user/:username' do  
#   erb ( current_user.name == params[:username] ? :users : :error )
# end

# get '/survey/:survey_id/stats' do
#    if current_user == Survey.find(params[:survey_id]).creator
#     erb :survey_stats, :locals => {:survey_id => params[:survey_id]}
#   else 
#     erb :error
#   end
# end


# get '/survey/:id' do
#   @survey = Survey.find_by_id(params[:id])
#   erb :take_survey
# end

# post '/submit/:id' do
#   @survey = Survey.find(params[:id])
#   @survey.questions.each do |question|
#     option_id = params["#{question.id}"]
#     Option.find(option_id).add_response!
#   end
#   redirect to '/'
# end
