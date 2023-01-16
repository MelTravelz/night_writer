require_relative "spec_helper" 

RSpec.describe NightWriter do 
  let(:night_writer) { NightWriter.new }

  before do
    night_writer.read_file = "./message.txt"
    night_writer.write_file = "./braille.txt"
  end

  describe "#initialize" do
    it "exists" do
      expect(night_writer).to be_instance_of(NightWriter)
    end

    it "has attributes" do
      night_writer.read_eng_write_brl

      expect(night_writer.read_file).to eq("./message.txt")
      expect(night_writer.write_file).to eq("./braille.txt")
      expect(night_writer.eng_brl_alphabet).to be_instance_of(Hash)
      expect(night_writer.eng_brl_alphabet["a"]).to eq(["0.", "..", ".."])
    end
  end

  describe "#translate_eng_to_brl" do
    it "can translate eng to brl" do
      night_writer.read_eng_write_brl

      expect(night_writer.translate_eng_to_brl("a")).to eq("0.\n..\n..")
      expect(night_writer.translate_eng_to_brl("abc")).to eq("0.0.00\n..0...\n......")
      expect(night_writer.translate_eng_to_brl("a b c")).to eq("0...0...00\n....0.....\n..........")
    end

    # it "can print multiple eng letters to brl letters" do
    #   night_writer.read_eng_write_brl

    #   expect(night_writer.translate_message("abc")).to eq("0.000.\n.....0\n......")
    #   expect(night_writer.translate_message("a b c")).to eq("0...00..0.\n.........0\n..........")
    # end

    # xit "can return message if special character/capital letter is included in message.txt" do
    #   night_writer.read_eng_write_brl
    #   allow(night_writer).to receive(:read_file).and_return("Hel-lo!")

    #   expect(night_writer.read_eng_write_brl).to eq("Your message contains invalid characters. Ensure you have ONLY lowercase english letters.")
    # end
  end

end