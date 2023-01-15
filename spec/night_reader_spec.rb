require_relative "spec_helper" 

RSpec.describe NightReader do 
  let(:night_reader) { NightReader.new }

  before do
    night_reader.read_file = "./braille.txt"
    night_reader.write_file = "original_message.txt"
  end

  describe "#initialize" do
    it "can initizlize an instance of NightReader" do
      expect(night_reader).to be_instance_of(NightReader)
    end

    it "has attributes" do
      night_reader.read_brl_write_eng

      expect(night_reader.read_file).to eq("./braille.txt")
      expect(night_reader.write_file).to eq("original_message.txt")
      expect(night_reader.eng_brl_alphabet).to be_instance_of(Hash)
      expect(night_reader.eng_brl_alphabet["a"]).to eq(["0.", "..", ".."])
    end
  end

  describe "#read_brl_write_eng" do
    xit "can translate brl to eng" do
      night_reader.read_brl_write_eng

      expect(night_reader.translate_brl_message("0.\n..\n..")).to eq("a")
      expect(night_writer.translate_brl_message("0.000.\n.....0\n......")).to eq("abc")
      expect(night_writer.translate_brl_message("0...00..0.\n.........0\n..........")).to eq("a b c")
    end

    # it "can print incoming text directly to the proper file" do
    #   result = File.read("./braille.txt")
    #   expect(result).to eq("hello world")
    # end
  end

end