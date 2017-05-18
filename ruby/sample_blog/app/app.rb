module SampleBlog
  class App < Padrino::Application
    use ConnectionPoolManagement
    register Padrino::Mailer
    register Padrino::Helpers
    enable :sessions

    get "/" do
      {message: "Hello, SampleBlog!"}.to_json
    end

    get :about, :map => '/about_us' do
      {message: "This is a sample blog created to demonstorate how Padrino works"}.to_json
    end
  end
end
