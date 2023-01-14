require_relative 'spec_helper' 

RSpec.describe NightWriter do 
  let(:night_writer) { NightWriter.new }
  # this is saying: These are the 2 arguments 
  # I expect to see in the command line

  before do
    night_writer.read_file = './message.txt'
    night_writer.write_file = './braille.txt'
  end

  it "exists" do
    expect(night_writer).to be_instance_of(NightWriter)
  end

  it "has attributes" do
    # could stub this method if using attr_reader: 
    # allow(night_writer).to receive(:read_file).and_return('./message.txt')
    # allow(night_writer).to receive(:write_file).and_return('./braille.txt')
    night_writer.read_from_write_to

    expect(night_writer.read_file).to eq('./message.txt')
    expect(night_writer.write_file).to eq('./braille.txt')
  end

end