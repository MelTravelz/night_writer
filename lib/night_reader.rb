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

    clean_brl_message = brl_message_array.reject { |row| "\n" if row == "" }
    # replaces empty space rows with single line break
    
    brl_row_array_by_index = clean_brl_message.each_slice(3).map do |brl_row_array|
      brl_row_array.map do |brl_row_string|
        brl_row_string.scan(/../)
      end
    end
    #returns triple array => [ [ [0],[1],[2] ], [ [0],[1],[2] ]  ]
    
    eng_message = brl_row_array_by_index.map do |index_position_arrays|
      index_position_arrays.transpose.map do |index_position_rows|
        eng_brl_alphabet.key(index_position_rows)
      end
    end.join
  
    eng_message.scan(/.{40}|.+/).join("\n")
  end
end

###### RUNNER #####
# comment out when running rspec!
# ruby ./lib/night_reader.rb braille.txt original_message.txt

# below is acting like a runner file: 

# night_reader = NightReader.new
# night_reader.read_brl_write_eng
