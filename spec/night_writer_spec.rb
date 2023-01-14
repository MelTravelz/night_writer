require_relative 'spec_helper' 

RSpec.describe NightWriter do 
  let(:night_writer) { NightWriter.new }

  before do
    night_writer.read_file = './message.txt'
    night_writer.write_file = './braille.txt'
  end

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