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

  def translate_eng_to_brl(incoming_text)
    message_array = create_message_array(incoming_text)
    braille_array = create_brl_array(message_array)
    braille_row_array = create_braille_row_array(braille_array)
  end

  def create_message_array(incoming_text)
    message_array = incoming_text.split("")
  end


  def create_brl_array(message_array)
    braille_array = message_array.filter_map do |letter|
      eng_brl_alphabet[letter]
    end
  end

  def create_braille_row_array(braille_array)
      braille_row_array = braille_array.each_slice(40).map do |array_of_40_letters| 
      array_of_40_letters.transpose.map do |index_postition_array|
        index_postition_array.join
      end.join("\n")
    end
    braille_row_array.join("\n\n")
  end


  def translate_brl_to_eng(incoming_text)
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