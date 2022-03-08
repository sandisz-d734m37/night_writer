module NightWriteable
  def count_characters(file)
    text = File.read(file)
    text = remove_unwanted_char(text)
    text.length
  end

  def print_to_terminal
    puts "Created file '#{ARGV[1]}' containing #{count_characters(@message)} characters"
  end
end
