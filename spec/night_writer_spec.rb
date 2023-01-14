require './lib/night_writer'

RSpec.describe NightWriter do 
  let(:night_writer) { NightWriter.new(ARGV[0], ARVG[1]) }
  # this is saying it expects to see 2 arguments in the command line

  it "exists" do
    expect(night_writer).to be_instance_of(NightWriter)
  end

end