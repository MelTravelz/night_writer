require_relative "spec_helper" 

RSpec.describe NightReader do 
  let(:night_reader) { NightReader.new }

  before do
    night_reader.read_file = "./braille.txt"
    night_reader.write_file = "original_message.txt"
    night_reader.read_brl_write_eng
  end

  describe "#initialize" do
    it "can initizlize an instance of NightReader" do
      expect(night_reader).to be_instance_of(NightReader)
    end

    it "has attributes" do
      expect(night_reader.read_file).to eq("./braille.txt")
      expect(night_reader.write_file).to eq("original_message.txt")
      expect(night_reader.eng_brl_alphabet).to be_instance_of(Hash)
      expect(night_reader.eng_brl_alphabet["a"]).to eq(["0.", "..", ".."])
    end
  end

  describe "#read_brl_write_eng" do
    it "can translate one brl character to eng" do
      expect(night_reader.translate_brl_to_eng("0.\n..\n..")).to eq("a")
    end
    
    it "can translate more than one brl character to eng" do
      expect(night_reader.translate_brl_to_eng("0.0.00\n..0...\n......")).to eq("abc")
      expect(night_reader.translate_brl_to_eng("0...0...00\n....0.....\n..........")).to eq("a b c")
    end

    # xit "can wrap eng letters to another line if over 40 eng characters in length" do
    #   expected =  
    #   expect(night_reader.translate_brl_to_eng("the quick brown fox jumps over the lazy dog")).to eq(expected)
    # end

  end

end