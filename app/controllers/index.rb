get '/' do
	session[:signin_input_error] = false
	session[:signup_input_error] = false
  erb :index
end
