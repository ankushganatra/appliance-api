require 'spec_helper'

describe HomeController, :type => :controller do

	describe "GET index" do
  
  	it "get action to index should be success" do
			get :index

      expect(response).to be_success
    end

    it "renders the index template" do
      get :index

      expect(response).to render_template("home/index")
    end

    it "defaults to showing 30 results per page" do

=begin
    	 @appliance = Appliance.create! name: "App1", customer: "customer1", targets: [FactoryGirl.create(:target)]
       @appliance.stub!(:current_page).and_return(1)
       @appliance..stub!(:num_pages).and_return(1)
       @appliance.stub!(:limit_value).and_return(1)
      Appliance.should_receive(:order).with("name")

      get :index
=end
    end

  end

end
