require_relative "language_converter.rb"

class NightReader < LanguageConverter
  
  def read_brl_write_eng
    incoming_brl_text = read_incoming_brl_file
    outgoing_translated_eng_text = translate_brl_to_eng(incoming_brl_text)
    write_outgoing_translated_eng_text(outgoing_translated_eng_text)
    print_terminal_message(outgoing_translated_eng_text)
  end
  
  def read_incoming_brl_file
    File.read(@read_file)
  end
  
  def write_outgoing_translated_eng_text(outgoing_translated_eng_text)
    File.write(@write_file, outgoing_translated_eng_text)
  end
  
  def print_terminal_message(outgoing_translated_eng_text)
    final_eng_text_length = outgoing_translated_eng_text.delete("\n").chars.count
    puts "Created #{@write_file} containing #{final_eng_text_length} characters."
    view_terminal_message_for_rspec(final_eng_text_length)
  end

  def view_terminal_message_for_rspec(final_eng_text_length)
    "Created #{@write_file} containing #{final_eng_text_length} characters"
  end

end

###### RUNNER #####
# comment out when running rspec!
# ruby ./lib/night_reader.rb braille.txt original_message.txt

# below is acting like a runner file: 

# night_reader = NightReader.new
# night_reader.read_brl_write_eng
