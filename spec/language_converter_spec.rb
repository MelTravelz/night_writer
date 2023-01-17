require_relative "spec_helper" 

RSpec.describe LanguageConverter do 
  let(:language_converter) { LanguageConverter.new }

  describe "#initialize" do
    before do
      language_converter.read_file = "./message.txt"
      language_converter.write_file = "./braille.txt"
    end

    it "exists" do
      expect(language_converter).to be_instance_of(LanguageConverter)
    end

    it "has attributes" do
      expect(language_converter.read_file).to eq("./message.txt")
      expect(language_converter.write_file).to eq("./braille.txt")
      
      expect(language_converter.eng_brl_alphabet).to be_instance_of(Hash)
      expect(language_converter.eng_brl_alphabet["a"]).to eq(['0.', '..', '..'])
    end
  end 

  describe "Translate English to Braille" do
    before do
      language_converter.read_file = "./message.txt"
      language_converter.write_file = "./braille.txt"
    end

    it "should #translate_eng_to_brl for one eng character" do
      expect(language_converter.translate_eng_to_brl("a")).to eq("0.\n..\n..")
    end

    it "should #translate_eng_to_brl for more than one eng character" do
      result = "0...0...00\n....0.....\n.........."
      expect(language_converter.translate_eng_to_brl("a b c")).to eq(result)
    end

    it "should #translate_eng_to_brl & wrap brl after 80 dot-characters" do
      result = ".00.0...000..0000...0.0.0..000..000.00...00.0000.0..0.0.0.0....00.0...0.0.0.00..\n"+ 
        "0000.0..00..0.......0.00.000.0..0..0..........0.0....00..000..0000.0..0....0.0..\n"+
        "0.......0.00....0.....0.0..00.....0.00....000.0.0...0.00..0...0.......0...0000..\n"+ 
        "\n000.00\n.0.000\n..0..."
      expect(language_converter.translate_eng_to_brl("the quick brown fox jumps over the lazy dog")).to eq(result)
    end

    it "should #translate_eng_to_brl & downcasing all capital letters" do
      result = "0.0.00..00000.\n..0........0.0\n........000000"
      expect(language_converter.translate_eng_to_brl("aBc xYz")).to eq(result)
    end

    it "should #translate_eng_to_brl & delete all unknown characters" do
      result = "0.0.00..00000.\n..0........0.0\n........000000"
      expect(language_converter.translate_eng_to_brl("abc! xyz?")).to eq(result)
    end

    it "should #create_array_of_eng_strings" do
      result = ["a", "b", "c", " ", "x", "y", "z"]
      expect(language_converter.create_array_of_eng_strings("abc xyz")).to eq(result)
    end

    it "should #create_brl_array" do
      result = [
        ["0.", "..", ".."], ['0.', '0.', '..'], ['00', '..', '..'], ['..', '..', '..'],
        ['00', '..', '00'], ['00', '.0', '00'], ['0.', '.0', '00']
      ]
      expect(language_converter.create_brl_array(["a", "b", "c", " ", "x", "y", "z"])).to eq(result)
    end

    it "should #create_braille_row_string" do
      brl_array_argument = [
        ["0.", "..", ".."], ['0.', '0.', '..'], ['00', '..', '..'], ['..', '..', '..'],
        ['00', '..', '00'], ['00', '.0', '00'], ['0.', '.0', '00']
      ]
      result = "0.0.00..00000.\n..0........0.0\n........000000"
      expect(language_converter.create_braille_row_string(brl_array_argument)).to eq(result)
    end
  end

  describe "Translate Braille to English" do
    before do
      language_converter.read_file = "./braille.txt"
      language_converter.write_file = "./original_message.txt"
    end

    it "should #translate_brl_to_eng for one character" do
      expect(language_converter.translate_brl_to_eng("0.\n.0\n00")).to eq("z")
    end
    
    it "should #translate_brl_to_eng for more than one brl character" do
      expect(language_converter.translate_brl_to_eng("00..00..0.\n.....0...0\n00..00..00")).to eq("x y z")
    end

    it "should #translate_eng_to_brl & wrap after 40 eng characters" do
      brl_string_argument = ".00.0...000..0000...0.0.0..000..000.00...00.0000.0..0.0.0.0....00.0...0.0.0.00..\n"+ 
        "0000.0..00..0.......0.00.000.0..0..0..........0.0....00..000..0000.0..0....0.0..\n"+
        "0.......0.00....0.....0.0..00.....0.00....000.0.0...0.00..0...0.......0...0000..\n"+ 
        "\n000.00\n.0.000\n..0..."
      result = "the quick brown fox jumps over the lazy \ndog"
      expect(language_converter.translate_brl_to_eng(brl_string_argument)).to eq(result)
    end

    it "should #create_array_of_brl_strings" do
      brl_text_argument = "0.0.00..00000.\n..0........0.0\n........000000"
      result =  ["0.0.00..00000.", "..0........0.0", "........000000"]
      expect(language_converter.create_array_of_brl_strings(brl_text_argument)).to eq(result)
    end

    it "should #create_no_extra_rows_array" do
      extra_row_argument =  ["0.0.00..00000.", "", "..0........0.0", "", "........000000"]
      result =  ["0.0.00..00000.", "..0........0.0", "........000000"]
      expect(language_converter.create_no_extra_rows_array(extra_row_argument)).to eq(result)
    end

    it "should #create_brl_row_by_index_array" do
      no_extra_rows_argument =  ["0.0.00..00000.", "..0........0.0", "........000000"]
      result = [ [ ["0.", "0.", "00", "..", "00", "00", "0."],["..", "0.", "..", "..", "..", ".0", ".0"],["..", "..", "..", "..", "00", "00", "00"] ] ]
      expect(language_converter.create_brl_row_by_index_array(no_extra_rows_argument)).to eq(result)
    end

    it "create_eng_row_string(brl_row_by_index_array)" do
      triple_array_argument = [ [ ["0.", "0.", "00", "..", "00", "00", "0."],["..", "0.", "..", "..", "..", ".0", ".0"],["..", "..", "..", "..", "00", "00", "00"] ] ]
      expect(language_converter.create_eng_row_string(triple_array_argument)).to eq("abc xyz")
    end
  end
end


