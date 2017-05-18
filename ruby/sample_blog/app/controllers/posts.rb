SampleBlog::App.controllers :posts do
  get :index do
    content_type 'application/json'
    @posts = Post.order('created_at DESC').all
    @posts ? @posts.to_json : {}.to_json
  end

  get :index, :with => :id do
    content_type 'application/json'
    @post = Post.find_by_id(params[:id])
    @post ? @post.to_json : {}.to_json
  end
end
