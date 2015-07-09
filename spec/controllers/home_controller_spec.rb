require 'spec_helper'

describe HomeController, :type => :controller do

	describe "GET index" do
  
  	it "get action to index should be success" do
			get :index

      response.should be_success    
    end

    it "renders the index template" do
      get :index

      response.should render_template("home/index")
    end

    it "defaults to showing 30 results per page" do

    	Appliance.create! name: "App1", customer: "customer1", targets: [FactoryGirl.create(:target)]

      Appliance.should_receive(:order).with("name")

      get :index
    end

  end

end
