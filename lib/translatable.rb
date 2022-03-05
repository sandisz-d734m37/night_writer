module Translatable
  def translate_to_braille(text)
    text.downcase!
    shortened_text = remove_unwanted_char(text)

    translated_text = shortened_text.each_char do |char|
      text['a'] = "~0.|..|..~" if char == 'a'
      text['b'] = "~0.|0.|..~" if char == 'b'
      text['c'] = "~00|..|..~" if char == 'c'
      text['d'] = "~00|.0|..~" if char == 'd'
      text['e'] = "~0.|.0|..~" if char == 'e'
      text['f'] = "~00|0.|..~" if char == 'f'
      text['g'] = "~00|00|..~" if char == 'g'
      text['h'] = "~0.|00|..~" if char == 'h'
      text['i'] = "~.0|0.|..~" if char == 'i'
      text['j'] = "~.0|00|..~" if char == 'j'
      text['k'] = "~0.|..|0.~" if char == 'k'
      text['l'] = "~0.|0.|0.~" if char == 'l'
      text['m'] = "~00|..|00~" if char == 'm'
      text['n'] = "~00|.0|0.~" if char == 'n'
      text['o'] = "~0.|.0|0.~" if char == 'o'
      text['p'] = "~00|0.|0.~" if char == 'p'
      text['q'] = "~00|00|0.~" if char == 'q'
      text['r'] = "~0.|00|0.~" if char == 'r'
      text['s'] = "~.0|0.|0.~" if char == 's'
      text['t'] = "~.0|00|0.~" if char == 't'
      text['u'] = "~0.|..|00~" if char == 'u'
      text['v'] = "~0.|0.|00~" if char == 'v'
      text['w'] = "~.0|00|.0~" if char == 'w'
      text['x'] = "~00|..|00~" if char == 'x'
      text['y'] = "~00|.0|00~" if char == 'y'
      text['z'] = "~0.|.0|00~" if char == 'z'
      text[' '] = "~..|..|..~" if char == ' '
    end

    clean_lines(translated_text)
  end

  def remove_unwanted_char(text)
    text.each_char do |char|
      if !"abcdefghijklmnopqrstuvwxyz".include?(char)
        text.delete!(char)
      end
    end
  end

  def clean_lines(text)
    text_to_clean = make_array(text)
    joined_arrays = array_to_text(text_to_clean)
    translated_chars = split_lines_by_three(joined_arrays)
    translated_chars.join "\n"
  end

  def make_array(text)
    partial_array = text.split("~")
    two_d_array = partial_array.map{|array| array.split("|")}
    text_to_clean = two_d_array.reject{|array| array.empty? || array[0] == "\n"}
  end

  def array_to_text(text)
    fourty_char_arrays = text.each_slice(40).to_a
    transposed_arrays = fourty_char_arrays.map { |row| row.transpose }
    joined_arrays = []
    transposed_arrays.each do |row|
      row.each { |sub_row| joined_arrays << sub_row.join(" ") }
    end
    joined_arrays
  end

  def split_lines_by_three(text)
    split_arrays = text.each_slice(3).to_a
    translated_chars = []
    split_arrays.each { |row| translated_chars << row.join("\n") }
    translated_chars
  end

end
