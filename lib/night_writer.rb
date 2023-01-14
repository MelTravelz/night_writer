class NightWriter
  attr_reader :eng_brl_alphabet
  attr_accessor :read_file, :write_file

  def initialize
    @read_file = ARGV[0]
    @write_file = ARGV[1]
    @eng_brl_alphabet = {
      "a" => ["0.", "..", ".."],
      "b" => ["00", "..", ".."],
      "c" => ["0.", ".0", ".."],
      "d" => ["0.", ".0", "0."],
      "e" => ["0.", "..", "0."],
      "f" => ["00", ".0", ".."],
      "g" => ["00", ".0", "0."],
      "h" => ["00", "..", "0."],
      "i" => [".0", ".0", ".."],
      "j" => [".0", ".0", "0."],
      "k" => ["0.", "0.", ".."],
      "l" => ["00", "0.", ".."],
      "m" => ["0.", "00", ".."],
      "n" => ["0.", "00", "0."],
      "o" => ["0.", "0.", "0."],
      "p" => ["00", "00", ".."],
      "q" => ["00", "00", "0."],
      "r" => ["00", "0.", "0."],
      "s" => [".0", "00", ".."],
      "t" => [".0", "00", "0."],
      "u" => ["0.", "0.", ".0"],
      "v" => ["00", "0.", ".0"],
      "w" => [".0", ".0", "00"],
      "x" => ["0.", "00", ".0"],
      "y" => ["0.", "00", "00"],
      "z" => ["0.", "0.", "00"]
      }
  end

  def read_from_write_to
    incoming_file = File.open(@read_file, "r")
    
    @incoming_text = incoming_file.read
    character_count = @incoming_text.chars.count
    puts "Created #{@write_file} contains #{character_count} characters"

    File.write(@write_file, @incoming_text)
  end

  def find_equivalent
    message_array = @incoming_text.split("")
    # array with string elements of letters

    message_array.map do |letter|
      eng_brl_alphabet[letter]
    end
    # returns array of array elements (braille) which has 3 string elements
  end
  
  def order_braille_for_printing
    find_equivalent.transpose
  end



end

###### RUNNER #####
# comment out when running rspec!
# below is acting like a runner file: 

# night_writer = NightWriter.new
# night_writer.read_from_write_to

