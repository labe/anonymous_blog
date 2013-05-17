post '/tag' do
	tag_name = params[:tag]
	redirect to "/tag/#{tag_name}"
end

get '/tag/:tag_name' do
	tag = Tag.where(:name => params[:tag_name]).first
	@post = tag.posts
	erb :post
end