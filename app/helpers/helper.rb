use Rack::Session::Cookie, 	:user_id => nil,
														:secret => "real pirates always call methods with ARRRRRRguments!",
														:expire_after => 86400,
														:destination => "/",
														:signup_input_error => false,
														:signin_input_error => false