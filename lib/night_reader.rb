class NightReader
  attr_reader :eng_brl_alphabet
  attr_accessor :read_file, :write_file

  def initialize
    @read_file = ARGV[0]
    @write_file = ARGV[1]
    @eng_brl_alphabet = {
      " " => ["..", "..", ".."],
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
  
  def read_brl_write_eng
    incoming_text = File.read(@read_file)

    outgoing_translated_text = translate_brl_message(incoming_text)
    
    File.write(@write_file, outgoing_translated_text)
    
    puts "Created #{@write_file} containing #{outgoing_translated_text.chars.count} characters."
  end

  def translate_brl_message(incoming_text)
    brl_message_array = incoming_text.split("\n")
    #=> returns ["0.0.00", "..0...", "......"]

    brl_row_array_by_index = brl_message_array.each_slice(3).flat_map do |brl_row_array|
      brl_row_array.map do |brl_row_string|
        brl_row_string.scan(/../)
      end
    end
    #returns [["0.", "..", "00", "..", "0."], ["..", "..", "..", "..", ".0"], ["..", "..", "..", "..", ".."]]
    
    eng_message = brl_row_array_by_index.transpose.map do |index_position_array|
      eng_brl_alphabet.key(index_position_array)
    end.join
    #returns "a b c"
    
    require 'pry'; binding.pry

    #COPIED FROM NIGHT WRITER - NEED TO REFACTOR FOR BRL -> ENG
    # braille_array = message_array.filter_map do |letter|
    #   eng_brl_alphabet[letter]
    # end

    # braille_row_array = braille_array.each_slice(40).map do |array_of_40_letters| 
    #   array_of_40_letters.transpose.map do |index_postition_array|
    #     index_postition_array.join
    #   end.join("\n")
    # end
    # braille_row_array.join("\n\n")

  end
end

###### RUNNER #####
# comment out when running rspec!
# ruby ./lib/night_reader.rb braille.txt original_message.txt

# below is acting like a runner file: 

# night_reader = NightReader.new
# night_reader.read_brl_write_eng
