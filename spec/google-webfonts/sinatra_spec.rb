# set up a Sinatra route to test
get("/") { google_webfonts_link_tag "Droid Sans" }

describe "Sinatra" do
  include Rack::Test::Methods
  
  def app
    Sinatra::Application
  end
  
  it "should include Google::Webfonts::Helper in Sinatra::Application" do
    Sinatra::Application.ancestors.should include Google::Webfonts::Helper
  end
  
  it "should respond to google_webfonts_link_tag" do
    tag = "<link href=\"http://fonts.googleapis.com/css?family=Droid+Sans\" rel=\"stylesheet\" type=\"text/css\" />"
    
    get "/"
    
    last_response.should be_ok
    last_response.body.should eq tag
  end
end
