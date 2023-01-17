require_relative "spec_helper" 

RSpec.describe NightWriter do 
  let(:night_writer) { NightWriter.new }

  before do
    night_writer.read_file = "fixture_message.txt"
    night_writer.write_file = "fixture_braille.txt"
  end

  describe "#initialize" do
    it "should initialize an instance of NightWriter" do
      expect(night_writer).to be_instance_of(NightWriter)
    end

    it "should have attributes" do
      expect(night_writer.read_file).to eq("fixture_message.txt")
      expect(night_writer.write_file).to eq("fixture_braille.txt")
      expect(night_writer.eng_brl_alphabet).to be_instance_of(Hash)
      expect(night_writer.eng_brl_alphabet["a"]).to eq(["0.", "..", ".."])
    end
  end

  describe "#read_eng_write_brl" do
    it "should #read_eng_write_brl & print message to terminal" do
      terminal_statement = "Created fixture_braille.txt containing 43 characters"
      expect(night_writer.read_eng_write_brl).to eq(terminal_statement)
    end

    it "should #read_incoming_eng_file & return string of eng characters" do
      expect(night_writer.read_incoming_eng_file).to eq("The quick brown fox jumps over the lazy dog.")
    end

    it "should #write_outgoing_translated_brl_text to new file" do
      brl_string_result = ".00.0...000..0000...0.0.0..000..000.00...00.0000.0..0.0.0.0....00.0...0.0.0.00..\n"+ 
        "0000.0..00..0.......0.00.000.0..0..0..........0.0....00..000..0000.0..0....0.0..\n"+
        "0.......0.00....0.....0.0..00.....0.00....000.0.0...0.00..0...0.......0...0000..\n"+ 
        "\n000.00\n.0.000\n..0..."
      night_writer.write_outgoing_translated_brl_text(brl_string_result)
      read_outgoing_brl_message_result = File.read("fixture_braille.txt")
      expect(read_outgoing_brl_message_result).to eq(brl_string_result)
    end

    it "should #print_terminal_message(outgoing_translated_brl_text)" do
      brl_string_argument = ".00.0...000..0000...0.0.0..000..000.00...00.0000.0..0.0.0.0....00.0...0.0.0.00..\n"+ 
        "0000.0..00..0.......0.00.000.0..0..0..........0.0....00..000..0000.0..0....0.0..\n"+
        "0.......0.00....0.....0.0..00.....0.00....000.0.0...0.00..0...0.......0...0000..\n"+ 
        "\n000.00\n.0.000\n..0..."
      expect(night_writer.print_terminal_message(brl_string_argument)).to eq("Created fixture_braille.txt containing 43 characters")
    end

    it "should return the #terminal_message" do
      length_argument = 55
      expect(night_writer.view_terminal_message_for_rspec(length_argument)).to eq("Created fixture_braille.txt containing 55 characters")
    end
  end
end