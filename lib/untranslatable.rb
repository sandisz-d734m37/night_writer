module Untranslatable
  def translate_from_braille(text)
    to_prepare = text.split("\n")
    until to_prepare[3].nil? do
      to_prepare = to_prepare.each_with_index.map{|line, index|
        thing = line + " " + to_prepare[index + 3] if to_prepare[index + 3]
        to_prepare[index + 3].clear if to_prepare[index + 3]
        thing
      }
    end
    to_prepare.reject! {|line| line.nil?}
    if to_prepare[0].length > 2
      to_prepare = to_prepare.map {|line| line.split(" ")}
      to_prepare = to_prepare.transpose
      prepared_text = to_prepare.map{|line| line.join("|")}
    else
      prepared_text = []
      prepared_text << to_prepare.join("|")
      # binding.pry
    end


    translated_text = []
    prepared_text.each do |char|
      # binding.pry
      translated_text << char.gsub("0.|..|..", "a") if char == "0.|..|.."
      translated_text << char.gsub("0.|0.|..", "b") if char == "0.|0.|.."
      translated_text << char.gsub("00|..|..", "c") if char == "00|..|.."
      translated_text << char.gsub("00|.0|..", "d") if char == "00|.0|.."
      translated_text << char.gsub("0.|.0|..", "e") if char == "0.|.0|.."
      translated_text << char.gsub("00|0.|..", "f") if char == "00|0.|.."
      translated_text << char.gsub("00|00|..", "g") if char == "00|00|.."
      translated_text << char.gsub("0.|00|..", "h") if char == "0.|00|.."
      translated_text << char.gsub(".0|0.|..", "i") if char == ".0|0.|.."
      translated_text << char.gsub(".0|00|..", "j") if char == ".0|00|.."
      translated_text << char.gsub("0.|..|0.", "k") if char == "0.|..|0."
      translated_text << char.gsub("0.|0.|0.", "l") if char == "0.|0.|0."
      translated_text << char.gsub("00|..|0.", "m") if char == "00|..|0."
      translated_text << char.gsub("00|.0|0.", "n") if char == "00|.0|0."
      translated_text << char.gsub("0.|.0|0.", "o") if char == "0.|.0|0."
      translated_text << char.gsub("00|0.|0.", "p") if char == "00|0.|0."
      translated_text << char.gsub("00|00|0.", "q") if char == "00|00|0."
      translated_text << char.gsub("0.|00|0.", "r") if char == "0.|00|0."
      translated_text << char.gsub(".0|0.|0.", "s") if char == ".0|0.|0."
      translated_text << char.gsub(".0|00|0.", "t") if char == ".0|00|0."
      translated_text << char.gsub("0.|..|00", "u") if char == "0.|..|00"
      translated_text << char.gsub("0.|0.|00", "v") if char == "0.|0.|00"
      translated_text << char.gsub(".0|00|.0", "w") if char == ".0|00|.0"
      translated_text << char.gsub("00|..|00", "x") if char == "00|..|00"
      translated_text << char.gsub("00|.0|00", "y") if char == "00|.0|00"
      translated_text << char.gsub("0.|.0|00", "z") if char == "0.|.0|00"
      translated_text << char.gsub("..|..|..", " ") if char == "..|..|.."
    end

    # clean_lines(translated_text)

    translated_text.join("")
  end

  def remove_unwanted_char(text)
    text.downcase!
    text.each_char do |char|
      if !"abcdefghijklmnopqrstuvwxyz ".include?(char)
        text.delete!(char)
      end
    end
  end

  # def clean_lines(text)
  #   text_to_clean = make_array(text)
  #   joined_arrays = array_to_text(text_to_clean)
  #   translated_chars = split_lines_by_three(joined_arrays)
  #   translated_chars.join "\n"
  # end
  #
  # def make_array(text)
  #   partial_array = text.each_slice(40).to_a
  #   two_d_array = partial_array.map{|array| array.split("|")}
  #   text_to_clean = two_d_array.reject{|array| array.empty? || array[0] == "\n"}
  # end
  #
  # def array_to_text(text)
  #   fourty_char_arrays = text.each_slice(40).to_a
  #   transposed_arrays = fourty_char_arrays.map { |row| row.transpose }
  #   joined_arrays = []
  #   transposed_arrays.each do |row|
  #     row.each { |sub_row| joined_arrays << sub_row.join(" ") }
  #   end
  #   joined_arrays
  # end
  #
  # def split_lines_by_three(text)
  #   split_arrays = text.each_slice(3).to_a
  #   translated_chars = []
  #   split_arrays.each { |row| translated_chars << row.join("\n") }
  #   translated_chars
  # end

end
