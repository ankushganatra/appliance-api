require 'spec_helper'

describe Target, :type => :model do
  let(:appliance) {Appliance.create! name: 'app1', customer: 'WhiteHat'}

  describe "#address" do
    it "validates IP addresses" do
      target = Target.new hostname: 'foo', address: '8.8.8.8', appliance: appliance
      expect(target.valid?).to be(true)
    end

    it "fails bad IP addresses" do
      target = Target.new hostname: 'foo', address: '888.888.888.888', appliance: appliance
      expect(target.valid?).to be(false)
    end
  end

  describe "valid model data" do
    
    it 'has a valid data' do
      expect(FactoryGirl.create(:target)).to be_valid
    end

    it 'is invalid without ip address' do
      expect(FactoryGirl.build(:target, address: nil)).to be_invalid 
    end

    it 'is invalid without appliance' do
      expect(FactoryGirl.build(:target, appliance: nil)).to be_invalid
    end
  end

end
