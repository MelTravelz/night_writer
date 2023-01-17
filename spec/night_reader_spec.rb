require_relative "spec_helper" 

RSpec.describe NightReader do 
  let(:night_reader) { NightReader.new }

  before do
    night_reader.read_file = "fixture_braille.txt"
    night_reader.write_file = "fixture_original_message.txt"
  end

  describe "#initialize" do
    it "should initialize an instance of NightReader" do
      expect(night_reader).to be_instance_of(NightReader)
    end

    it "should have attributes" do
      expect(night_reader.read_file).to eq("fixture_braille.txt")
      expect(night_reader.write_file).to eq("fixture_original_message.txt")
      expect(night_reader.eng_brl_alphabet).to be_instance_of(Hash)
      expect(night_reader.eng_brl_alphabet["z"]).to eq(['0.', '.0', '00'])
    end
  end

  describe "#read_brl_write_eng" do
    it "should #read_brl_write_eng & print message to terminal" do
      terminal_statement = "Created fixture_original_message.txt containing 43 characters"
      expect(night_reader.read_brl_write_eng).to eq(terminal_statement)
    end

    it "should #read_incoming_brl_file & return brl characters" do
      brl_string_result = ".00.0...000..0000...0.0.0..000..000.00...00.0000.0..0.0.0.0....00.0...0.0.0.00..\n"+ 
        "0000.0..00..0.......0.00.000.0..0..0..........0.0....00..000..0000.0..0....0.0..\n"+
        "0.......0.00....0.....0.0..00.....0.00....000.0.0...0.00..0...0.......0...0000..\n"+ 
        "\n000.00\n.0.000\n..0..."
      expect(night_reader.read_incoming_brl_file).to eq(brl_string_result)
    end

    it "should #write_outgoing_translated_eng_text to new file" do
      eng_string_result = "the quick brown fox jumps over the lazy \ndog"
      night_reader.write_outgoing_translated_eng_text(eng_string_result)
      read_outgoing_brl_message_result = File.read("fixture_original_message.txt")
      expect(read_outgoing_brl_message_result).to eq(eng_string_result)
    end

    it "should #print_terminal_message(outgoing_translated_brl_text)" do
      eng_string_argument = "the quick brown fox jumps over the lazy \ndog"
      expect(night_reader.print_terminal_message(eng_string_argument)).to eq("Created fixture_original_message.txt containing 43 characters")
    end

    it "should return the #terminal_message" do
      length_argument = 100
      expect(night_reader.view_terminal_message_for_rspec(length_argument)).to eq("Created fixture_original_message.txt containing 100 characters")
    end
  end

end