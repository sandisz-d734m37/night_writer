module Untranslatable

  


  def remove_unwanted_char(text)
    text.downcase!
    text.each_char do |char|
      if !"abcdefghijklmnopqrstuvwxyz".include?(char)
        text.delete!(char)
      end
    end
  end
end
