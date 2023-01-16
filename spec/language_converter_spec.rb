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

      expect(language_converter.eng_brl_alphabet["a"]).to eq(['0.', '..', '..'])
    end
  end 
end

