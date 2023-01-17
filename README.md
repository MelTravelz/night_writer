### Notes to Users

**Order of Operations**
1) Open < message.txt > and write any message you'd like to be printed into braille

2) In the terminal, paste & run < ruby ./lib/night_writer.rb message.txt braille.txt > 
  - This will create a file named < braille.txt >

3) Then, paste & run < ruby ./lib/night_reader.rb braille.txt original_message.txt >
  - This will create a file named < original_message.txt >

**Order of Operations for Rspec (to check the spec files):**
1) Go to <./lib/night_writer.rb> & comment out lines 33, 34:
  night_writer = NightWriter.new
  night_writer.read_eng_write_brl

2) Then, go to <./lib/night_reader.rb> & comment out lines 33, 34: 
  night_reader = NightReader.new
  night_reader.read_brl_write_eng

3) In the terminal, paste & run < ruby ./lib/night_writer.rb fixture_message.txt fixture_braille.txt >

4) Then, paste & run < ruby ./lib/night_reader.rb fixture_braille.txt fixture_original_message.txt >