handle = File.open(ARGV[0], "r")

incoming_text = handle.read

# puts incoming_text

rumi_poem_capitalized = incoming_text.upcase

writer = File.open(ARGV[1], "w")

writer.write(rumi_poem_capitalized)

writer.close