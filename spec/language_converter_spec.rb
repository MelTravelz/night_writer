require_relative "spec_helper" 

RSpec.describe LanguageConverter do 
  let(:language_converter) { LanguageConverter.new }

  before do
    language_converter.read_file = "./message.txt"
    language_converter.write_file = "./braille.txt"
  end

  describe "#initialize" do
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
    it "should #translate_eng_to_brl" do
      expected = "0...0...00\n....0.....\n.........."
      expect(language_converter.translate_eng_to_brl("a b c")).to eq(expected)
    end

    it "should translate capital eng letters to brl" do
      expected = "0.0.00..00000.\n..0........0.0\n........000000"
      expect(language_converter.translate_eng_to_brl("ABC XYZ")).to eq(expected)
    end

    it "should delete all unknown characters and translate eng to brl" do
      expected = "0.0.00..00000.\n..0........0.0\n........000000"
      expect(language_converter.translate_eng_to_brl("abc! xyz?")).to eq(expected)
    end

    it "should #create_array_of_eng_strings" do
      expected = ["a", "b", "c", " ", "x", "y", "z"]
      expect(language_converter.create_array_of_eng_strings("abc xyz")).to eq(expected)
    end

    it "should #create_brl_array" do
      expected = [
        ["0.", "..", ".."], ['0.', '0.', '..'], ['00', '..', '..'], ['..', '..', '..'],
        ['00', '..', '00'], ['00', '.0', '00'], ['0.', '.0', '00']
      ]
      expect(language_converter.create_brl_array(["a", "b", "c", " ", "x", "y", "z"])).to eq(expected)
    end

    # it "should also delete all nil/unknown characters within #create_brl_array" do
    #   expected = [
    #     ["0.", "..", ".."], ['0.', '0.', '..'], ['00', '..', '..'], ['..', '..', '..'],
    #     ['00', '..', '00'], ['00', '.0', '00'], ['0.', '.0', '00']
    #   ]
    #   expect(language_converter.create_brl_array(["a", "b", "c", "!", " ", "x", "y", "z", "?"])).to eq(expected)
    # end

    it "should #create_braille_row_string" do
      brl_array_argument = [
        ["0.", "..", ".."], ['0.', '0.', '..'], ['00', '..', '..'], ['..', '..', '..'],
        ['00', '..', '00'], ['00', '.0', '00'], ['0.', '.0', '00']
      ]
      expected = "0.0.00..00000.\n..0........0.0\n........000000"
      expect(language_converter.create_braille_row_string(brl_array_argument)).to eq(expected)
    end
  end

  describe "Translate Braille to English" do
    it "should #translate_brl_to_eng" do
      expect(language_converter.translate_brl_to_eng("00..00..0.\n.....0...0\n00..00..00")).to eq("x y z")
    end

    it "should #create_array_of_brl_strings" do
      brl_text_argument = "0.0.00..00000.\n..0........0.0\n........000000"
      expected =  ["0.0.00..00000.", "..0........0.0", "........000000"]
      expect(language_converter.create_array_of_brl_strings(brl_text_argument)).to eq(expected)
    end

    it "should #create_no_extra_rows_array" do
      extra_row_argument =  ["0.0.00..00000.", "", "..0........0.0", "", "........000000"]
      expected =  ["0.0.00..00000.", "..0........0.0", "........000000"]
      expect(language_converter.create_no_extra_rows_array(extra_row_argument)).to eq(expected)
    end

    it "should #create_brl_row_by_index_array" do
      no_extra_rows_argument =  ["0.0.00..00000.", "..0........0.0", "........000000"]
      expected = [ [ ["0.", "0.", "00", "..", "00", "00", "0."],["..", "0.", "..", "..", "..", ".0", ".0"],["..", "..", "..", "..", "00", "00", "00"] ] ]
      expect(language_converter.create_brl_row_by_index_array(no_extra_rows_argument)).to eq(expected)
    end

    it "create_eng_row_string(brl_row_by_index_array)" do
      triple_array_argument = [ [ ["0.", "0.", "00", "..", "00", "00", "0."],["..", "0.", "..", "..", "..", ".0", ".0"],["..", "..", "..", "..", "00", "00", "00"] ] ]
      expect(language_converter.create_eng_row_string(triple_array_argument)).to eq("abc xyz")
    end

  end
end

