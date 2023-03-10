require_relative "language_converter.rb"

class NightWriter < LanguageConverter

  def read_eng_write_brl
    incoming_eng_text = read_incoming_eng_file
    outgoing_translated_brl_text = translate_eng_to_brl(incoming_eng_text)
    write_outgoing_translated_brl_text(outgoing_translated_brl_text)
    print_terminal_message(outgoing_translated_brl_text)
  end
  
  def read_incoming_eng_file
    File.read(@read_file)
  end
  
  def write_outgoing_translated_brl_text(outgoing_translated_brl_text)
    File.write(@write_file, outgoing_translated_brl_text)
  end
  
  def print_terminal_message(outgoing_translated_brl_text)
    final_brl_text = outgoing_translated_brl_text.delete("\n").chars.count
    final_text_eng_chr_count = (final_brl_text / 6)
    puts "Created #{@write_file} containing #{final_text_eng_chr_count} characters"
    view_terminal_message_for_rspec(final_text_eng_chr_count)
  end

  def view_terminal_message_for_rspec(final_text_eng_chr_count)
    "Created #{@write_file} containing #{final_text_eng_chr_count} characters"
  end
end

###### RUNNER #####
night_writer = NightWriter.new
night_writer.read_eng_write_brl