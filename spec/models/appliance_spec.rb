require 'spec_helper'

describe Appliance, :type => :model do
  describe "#new" do
    it "validates unique appliance names" do
      Appliance.create name: 'app1', customer: 'WhiteHat'
      appliance = Appliance.new name: 'app1', customer: 'WhiteHat'
      expect(appliance.save).to be(false)
    end
  end

  describe "valid model data" do
  	
  	it 'has a valid data' do
  		expect(FactoryGirl.create(:appliance)).to be_valid
  	end

  	it 'is invalid without name' do
  		expect(FactoryGirl.build(:appliance, name: nil)).to be_invalid 
  	end

  	it 'is invalid without customer' do
  		expect(FactoryGirl.build(:appliance, customer: nil)).to be_invalid
  	end

  end

  describe "class methods" do 

  	before :each do
  		` > output.log`
  	end

    it "should return true if ip address is reachable" do
      expect(Appliance.ping_status('127.0.0.1')).to be(true)
    end

    it "should return false if ip address can not be reached" do
      expect(Appliance.ping_status('4.68.25.165')).to be(false)
    end
  end

end
