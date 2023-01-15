require_relative 'spec_helper' 

RSpec.describe NightReader do 
  let(:night_reader) { NightReader.new }



  describe "#initialize" do
    it "can initizlize an instance of NightReader" do
      expect(night_reader).to be_instance_of(NightReader)
    end
  end

end