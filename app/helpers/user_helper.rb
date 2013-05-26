def current_user
  User.where(:id => session[:user_id]).first
end

def has_album
	if current_user.albums == nil
		false
	end
end

def album_exists(album)
	if Album.find_by_name(album).nil? 
			false
		else
			true
	end
end



