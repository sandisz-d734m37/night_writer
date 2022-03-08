module Untranslatable
  def translate_from_braille(text)
    # binding.pry
    prepared_text = clean_lines(text)

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

  def clean_lines(text)
    prepped = prep_text(text)
    split_transpose_join(prepped)
  end

  def prep_text(text)
    to_prepare = text.split("\n")
    until to_prepare[3].nil? do
      to_prepare = to_prepare.each_with_index.map{|line, index|
        prepped_line = line + " " + to_prepare[index + 3] if to_prepare[index + 3]
        to_prepare[index + 3].clear if to_prepare[index + 3]
        prepped_line
      }
    end
    to_prepare.reject! {|line| line.nil?}
    to_prepare
  end

  def split_transpose_join(text)
    if text[0].length > 2
      text = text.map {|line| line.split(" ")}
      text = text.transpose
      prepared_text = text.map{|line| line.join("|")}
    else
      prepared_text = []
      prepared_text << text.join("|")
      # binding.pry
    end
    prepared_text
    # binding.pry
  end
end
