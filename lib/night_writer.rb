class NightWriter
  attr_accessor :read_file, :write_file
    # when running ruby/runner maybe use this: 
    # attr_reader :read_file, :write_file

  def initialize
    @read_file = ARGV[0]
    @write_file = ARGV[1]
  end

  def read_from_write_to
    incoming_file = File.open(@read_file, "r")
    # outgoing_file = File.new(@write_file, "w")
    
    text = incoming_file.read
    character_count = text.chars.count
  
    puts "Created #{@write_file} contains #{character_count} characters"
    # # require 'pry'; binding.pry

    File.write(@write_file, text)
  end
end

# below is acting like a runner file: 
# comment out when running rspec!

# night_writer = NightWriter.new
# night_writer.read_from_write_to