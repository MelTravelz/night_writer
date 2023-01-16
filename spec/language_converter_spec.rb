require_relative "spec_helper" 

RSpec.describe LanguageConverter do 
  let(:language_converter) { LanguageConverter.new }

  describe "#initialize" do
    it "exists" do
      expect(language_converter).to be_instance_of(LanguageConverter)
    end

    it "has attributes" do
      expect(language_converter.eng_brl_alphabet["a"]).to eq(['0.', '..', '..'])
    end
  end 
end

