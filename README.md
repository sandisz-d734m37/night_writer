#_NIGHT WRITER_#

Night Writer is a program you can use to take regular text written in one file, and translate it to braille in another, new or overwritten file!

Just enter the correct directory (this directory), open it in your text editor of choice, write your message of choice into the `message.txt` file, then run `$ ruby ./lib/night_writer.rb message.txt braille.txt` into your terminal. Once this is complete, check your `braille.txt` file to see how your message translated into braille!

Once you've done all of that, run `$ ruby ./lib/night_reader.rb braille.txt original_message.txt` in your terminal and you'll see your original message from the `message.txt` file translated, back from braille in the `original_message.txt` file!
