def pirate(arrrrrrrrg)
	puts "Avast!"
end

get '/create_post' do
	session[:destination] = "/"
	erb :create_post
end

post '/create_post' do
	p params.inspect
	title = params[:title]
	body = params[:body]
	user_id = session[:user_id]
	post = Post.create!(:title => title, :body => body, :user_id => user_id)
	post.add_tags(params[:tags])
	redirect to "post/#{post.id}"
end

get '/post/:id' do
	p params.inspect
	id = params[:id]
	@post = Post.where(:id => id)
	erb :post
end

post '/search' do
	search_string = params[:search_titles]
	@post = Post.search_posts(search_string)
	erb :post
end

get '/all_posts' do
	@post = Post.all
	erb :post
end

get '/edit_post/:id' do
	id = params[:id]
	@post = Post.find(id)
	if @post.user_id == session[:user_id]
		erb :edit_post
	else
		erb :bad_user
	end
end

post '/edit_post/:id' do
	id = params[:id]
	title = params[:title]
	body = params[:body]
	Post.find(id).add_tags(params[:tags])
	Post.update(id, :title => title, :body => body)
	redirect to "post/#{id}"
end

post 'edit_post/' do
	id = params[:id]
	redirect to "post/#{id}"
end

post '/delete_post' do
	id = params[:id]
	Post.find(id).delete
	redirect to "/post_deleted"
end

get '/post_deleted' do
	erb :post_deleted
end