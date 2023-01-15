require_relative 'spec_helper' 

RSpec.describe NightReader do 
  let(:night_reader) { NightReader.new }

  describe "#initialize" do
    it "can initizlize an instance of NightReader" do
      expect(night_reader).to be_instance_of(NightReader)
    end
  end

  describe "#read_brl_write_eng" do
    it "can print incoming text directly to the proper file" do
      result = File.read("./braille.txt")

      expect(result).to eq("hello world")
    end
  end

end