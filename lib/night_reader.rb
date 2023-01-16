require_relative "language_converter.rb"

class NightReader < LanguageConverter
  
  def read_brl_write_eng
    incoming_brl_text = File.read(@read_file)

    outgoing_translated_eng_text = translate_brl_to_eng(incoming_brl_text)
    
    File.write(@write_file, outgoing_translated_eng_text)
    
    puts "Created #{@write_file} containing #{outgoing_translated_eng_text.chars.count} characters."
  end

end

###### RUNNER #####
# comment out when running rspec!
# ruby ./lib/night_reader.rb braille.txt original_message.txt

# below is acting like a runner file: 

# night_reader = NightReader.new
# night_reader.read_brl_write_eng
