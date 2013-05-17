get '/check_user_session' do 
	session[:destination] = "/create_post"
	if session[:user_id]
		redirect to "/create_post"
	else 
		redirect to "/login"
	end
end

get '/login' do
	session[:signup_input_error] = false
	erb :login
end

post '/sign_in' do
	if (user = User.where(:email => params[:email]).first) && user.password == params[:password]
		session[:user_id] = user.id
		session[:signin_input_error] = false
		redirect to "#{session[:destination]}"
	else
		session[:signin_input_error] = true
		redirect to "/login"
	end
end

get '/create_user_account' do 
	session[:signin_input_error] = false
	erb :create_account
end

post '/create_user_account' do
	name = params[:name]
	email = params[:email]
	password = params[:password]
	validate_account_creation(name, email, password)
end

get '/logout' do
	session[:user_id] = nil
	session[:signin_input_error] = false
	session[:signup_input_error] = false
	redirect to "/"
end

def validate_account_creation(name, email, password)
	if User.where(:email => email) == []
		link_id = email.hash.to_s(36)
		user = User.create!(:name => name, :email => email, :password => password, :link_id => link_id)
		session[:user_id] = user.id
		session[:signup_input_error] = false
		redirect to "#{session[:destination]}"
	else
		session[:signup_input_error] = true
		redirect to "/create_user_account"
	end
end