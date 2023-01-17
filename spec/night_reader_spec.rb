require_relative "spec_helper" 

RSpec.describe NightReader do 
  let(:night_reader) { NightReader.new }

  before do
    night_reader.read_file = "./braille.txt"
    night_reader.write_file = "./original_message.txt"
    night_reader.read_brl_write_eng
  end

  describe "#initialize" do
    it "should initialize an instance of NightReader" do
      expect(night_reader).to be_instance_of(NightReader)
    end

    it "should have attributes" do
      expect(night_reader.read_file).to eq("./braille.txt")
      expect(night_reader.write_file).to eq("./original_message.txt")
      expect(night_reader.eng_brl_alphabet).to be_instance_of(Hash)
      expect(night_reader.eng_brl_alphabet["z"]).to eq(['0.', '.0', '00'])
    end
  end
  
  # def "#read_brl_write_eng" do
  # end

end