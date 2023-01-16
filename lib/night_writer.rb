class NightWriter
  attr_reader :eng_brl_alphabet
  attr_accessor :read_file, :write_file

  def initialize
    @read_file = ARGV[0]
    @write_file = ARGV[1]
    @eng_brl_alphabet = {
      ' ' => ['..', '..', '..'],
      'a' => ['0.', '..', '..'],
      'b' => ['0.', '0.', '..'],
      'c' => ['00', '..', '..'],
      'd' => ['00', '.0', '..'],
      'e' => ['0.', '.0', '..'],
      'f' => ['00', '0.', '..'],
      'g' => ['00', '00', '..'],
      'h' => ['0.', '00', '..'],
      'i' => ['.0', '0.', '..'],
      'j' => ['.0', '..', '..'],
      'k' => ['0.', '..', '0.'],
      'l' => ['0.', '0.', '0.'],
      'm' => ['00', '..', '0.'],
      'n' => ['00', '.0', '0.'],
      'o' => ['0.', '.0', '0.'],
      'p' => ['00', '0.', '0.'],
      'q' => ['00', '00', '0.'],
      'r' => ['0.', '00', '0.'],
      's' => ['.0', '0.', '0.'],
      't' => ['.0', '00', '0.'],
      'u' => ['0.', '..', '00'],
      'v' => ['0.', '0.', '00'],
      'w' => ['.0', '00', '.0'],
      'x' => ['00', '..', '00'],
      'y' => ['00', '.0', '00'],
      'z' => ['0.', '.0', '00']
    }
  end



  def read_eng_write_brl
    incoming_text = File.read(@read_file)
    
    outgoing_translated_text = translate_eng_message(incoming_text)
    
    File.write(@write_file, outgoing_translated_text)
    
    puts "Created #{@write_file} contains #{incoming_text.chars.count} characters"
  end



  def translate_eng_message(incoming_text)
    message_array = incoming_text.split("")

    braille_array = message_array.filter_map do |letter|
      # message_array.map do |letter|
      eng_brl_alphabet[letter]
    end
    # returns array of array elements (braille) which has 3 string elements
    # "abc" => [["0.", "..", ".."], ["00", "..", ".."], ["0.", ".0", ".."]]
    
    braille_row_array = braille_array.each_slice(40).map do |array_of_40_letters| 
      array_of_40_letters.transpose.map do |index_postition_array|
        index_postition_array.join
      end.join("\n")
    end
    #returns array of arrays of: first 40 -> index[0],[1],[2] & second 40 -> index[0],[1],[2] ...

    braille_row_array.join("\n\n")
    # returns => ".0000...00\n00......00\n0.0.0...0.\n\n0..00.0...\n0.. ..."
    
  end

end

###### RUNNER #####
# comment out when running rspec!
#ruby ./lib/night_writer.rb message.txt braille.txt

# below is acting like a runner file: 

# night_writer = NightWriter.new
# night_writer.read_eng_write_brl





######### ATEMPT AT HELPER METHODS - NOT WORKING ###########
# def read_from_write_to
#   incoming_text = File.read(@read_file)

#   character_count = incoming_text.chars.count
#   puts "Created #{@write_file} contains #{character_count} characters"

#   outgoing_translated_text = translate_message(incoming_text)
#   # message_array = translate_message(incoming_text)
#   # braille_array = find_equivalent(message_array)
#   # outgoing_translated_text = order_braille_for_printing(braille_array)

#   File.write(@write_file, outgoing_translated_text)
# end

# def translate_message(incoming_text)
#   incoming_text.split("")
#   # array with string elements of letters
#   # braille_array = find_equivalent(message_array)
#   # order_braille_for_printing(braille_array)
# end

# def find_equivalent(message_array)
#   message_array.filter_map do |letter|
#     # message_array.map do |letter|

#     eng_brl_alphabet[letter]
#   end
# end
# # returns array of array elements (braille) which has 3 string elements

# def order_braille_for_printing(braille_array)
#   result = braille_array.transpose.map do |index_post_array|
#     index_post_array.join
#   end.join("\n")
#   result.compact
# end
# # above is same as: find_equivalent.transpose.map(&:join).join("\n")


######### 
  # braille_array.transpose.map do |index_post_array|
  #   index_post_array.join
  # end.join("\n")
  # joins each inner array to return a single string element with line breaks between "rows"
  # reutrns => "0.000.\n.....0\n......"
