class LanguageConverter
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

################# ENGLISH TO BRAILLE TRANSLATION #################

  def translate_eng_to_brl(incoming_eng_text)
    array_of_eng_strings = create_array_of_eng_strings(incoming_eng_text)
    braille_array = create_brl_array(array_of_eng_strings)
    braille_row_string = create_braille_row_string(braille_array)
  end

################# HELPERS #################

  def create_array_of_eng_strings(incoming_eng_text)
    array_of_eng_strings = incoming_eng_text.downcase.split("")
  end
  #=> returns ["a", " ", "b", " ", "c"]

  def create_brl_array(array_of_eng_strings)
    braille_array = array_of_eng_strings.filter_map do |letter| 
      eng_brl_alphabet[letter]
    end
  end
  #=> returns "abc" = [["0.", "..", ".."], ['0.', '..', '..'], ['00', '..', '..']]

  def create_braille_row_string(braille_array)
      braille_row_string = braille_array.each_slice(40).map do |array_of_40_letters| 
      array_of_40_letters.transpose.map do |index_postition_array|
        index_postition_array.join
      end.join("\n")
    end
    #=> returns array of arrays of: first 40 -> index[0],[1],[2] & second 40 -> index[0],[1],[2] ...
    braille_row_string.join("\n\n")
  end
  # returns => ".0000...00\n00......00\n0.0.0...0.\n\n0..00.0...\n0.. ..."

################# BRAILLE TO ENGLISH TRANSLATION #################
  
  def translate_brl_to_eng(incoming_brl_text)
    array_of_brl_strings = create_array_of_brl_strings(incoming_brl_text)
    no_extra_rows_array = create_no_extra_rows_array(array_of_brl_strings)
    brl_row_by_index_array = create_brl_row_by_index_array(no_extra_rows_array)
    eng_row_string = create_eng_row_string(brl_row_by_index_array)
  end

################# HELPERS #################

  def create_array_of_brl_strings(incoming_brl_text)
    array_of_brl_strings = incoming_brl_text.split("\n")
  end
  #=> returns ["0.0.00", "..0...", "......"]

  def create_no_extra_rows_array(array_of_brl_strings)
    no_extra_rows_array = array_of_brl_strings.reject do |row| 
      "\n" if row == "" 
    end
  end
  #=> returns previous-like array but replaces empty space-rows with single line break

  def create_brl_row_by_index_array(no_extra_rows_array)
    brl_row_by_index_array = no_extra_rows_array.each_slice(3).map do |brl_row_array|
      brl_row_array.map do |brl_row_string|
        brl_row_string.scan(/../)
      end
    end
  end
  #=> returns triple array: [ [ [0],[1],[2] ], [ [0],[1],[2] ]  ]
  
  def create_eng_row_string(brl_row_by_index_array)
    eng_row_string = brl_row_by_index_array.map do |index_position_arrays|
      index_position_arrays.transpose.map do |index_position_rows|
        eng_brl_alphabet.key(index_position_rows)
      end
    end.join
    #=> returns string of english characters (ex: "a b c")
    eng_row_string.scan(/.{40}|.+/).join("\n")
  end
  #=> wraps english characters (ex: "a b c") to next line after 40 characters
  #=> good test sentence: "the quick brown fox jumps over the lazy dog"
end