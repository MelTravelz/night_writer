require_relative "language_converter.rb"

class NightWriter < LanguageConverter

  def read_eng_write_brl
    incoming_eng_text = File.read(@read_file)
    
    outgoing_translated_brl_text = translate_eng_to_brl(incoming_eng_text)
    
    File.write(@write_file, outgoing_translated_brl_text)
    
    puts "Created #{@write_file} contains #{incoming_eng_text.chars.count} characters"
  end

end

###### RUNNER #####
# comment out when running rspec!
# ruby ./lib/night_writer.rb message.txt braille.txt

# below is acting like a runner file: 

# night_writer = NightWriter.new
# night_writer.read_eng_write_brl

