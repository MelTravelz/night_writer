require_relative 'spec_helper' 

RSpec.describe NightWriter do 
  let(:night_writer) { NightWriter.new }

  before do
    night_writer.read_file = './message.txt'
    night_writer.write_file = './braille.txt'
  end

  describe "#initialize" do
    it "exists" do
      expect(night_writer).to be_instance_of(NightWriter)
    end

    it "has attributes" do
      night_writer.read_from_write_to

      expect(night_writer.read_file).to eq('./message.txt')
      expect(night_writer.write_file).to eq('./braille.txt')
      expect(night_writer.eng_brl_alphabet).to be_instance_of(Hash)
      expect(night_writer.eng_brl_alphabet["a"]).to eq(["0.", "..", ".."])
    end
  end

  describe "#translate_message" do
    it "can print one eng letter to a brl letter" do
      night_writer.read_from_write_to

      expect(night_writer.translate_message("a")).to eq("0.\n..\n..")
    end

    it "can print multiple eng letters to brl letters" do
      night_writer.read_from_write_to

      expect(night_writer.translate_message("abc")).to eq("0.000.\n.....0\n......")
    end
  end

  ######### ATEMPT AT HELPER METHODS - NOT WORKING ###########

  # describe "#find_equivalent" do
  #   xit "can iterate through message text and match alphabet letters to produce array of braille text" do
  #     night_writer.read_from_write_to
      
  #     expect(night_writer.find_equivalent("abc")).to eq([["0.", "..", ".."], ["00", "..", ".."], ["0.", ".0", ".."]])
  #   end
  # end

  # describe "#order_braille_for_printing" do
  #   xit "orders 3 index position of braille chars into 3 arrays of printable rows " do
  #     night_writer.read_from_write_to

  #     expect(night_writer.order_braille_for_printing).to eq("0.000.\n.....0\n......")

  #     #index[0] => ["0.", "00", "0."]
  #     #index[1] => ["..", "..", ".0"]
  #     #index[2] => ["..", "..", ".."]
  #   end
  # end
end