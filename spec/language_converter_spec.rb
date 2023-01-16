require_relative "spec_helper" 

RSpec.describe LanguageConverter do 
  let(:language_converter) { LanguageConverter.new }

  describe "#initialize" do
    it "exists" do

      expect(language_converter).to be_instance_of(LanguageConverter)
    end
  end 
end

