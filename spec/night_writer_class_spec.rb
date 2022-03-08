require './lib/night_writer'
require './lib/night_writer_class'
require 'tempfile'

RSpec.describe NightWriter do
  let(:night_writer) { NightWriter.new(arguments) }

  let(:arguments) { [test_message.path, test_braille.path] }
  let(:test_braille) { Tempfile.new('txt')}
  let(:test_message) do
    Tempfile.new('txt').tap do |msg|
      msg << "nothing"
      msg.close
    end
  end

  after do
    test_message.unlink
    test_braille.unlink
  end

  it "exists" do
    expect(night_writer).to be_a NightWriter
  end

  it "can open a file" do
    # binding.pry
    expect(night_writer.message.readlines).to eq(["nothing"])
  end

  it "can modify text and write to a file" do
    night_writer.readfile
    expect(File.open(test_braille.path).readlines.length).to eq(3)
  end

  it "can count characters in the message file print to the terminal" do
    expect { night_writer }.to output("Created file '#{ARGV[1]}' containing 7 characters\n").to_stdout
  end
end

RSpec.describe "Translatable" do
  let(:night_writer) { NightWriter.new(arguments) }

  let(:arguments) { [test_message.path, test_braille.path] }
  let(:test_braille) { Tempfile.new('txt')}
  let(:test_message) do
    Tempfile.new('txt').tap do |msg|
      msg << "nothing"
      msg.close
    end
  end

  after do
    test_message.unlink
    test_braille.unlink
  end

  it "exists" do
    expect(night_writer).to be_a NightWriter
  end

  it "can interact with files" do
    expect(File.open(test_message.path).readlines).to eq(["nothing"])
  end

  it "can translate english to braille" do
    expect(night_writer.translate_to_braille("x")).to eq("00\n..\n00")
  end

  it "will not break if passed a non-alphabetic or uppercase character" do
    expect(night_writer.translate_to_braille("!@#$%&())(*)}/>,<+}][{}]|\||\n\n\n\n...xX......")).to eq("00 00\n.. ..\n00 00")
  end

  it "can remove unwanted characters" do
    expect(night_writer.remove_unwanted_char("!@#$%&())(*)}/>,<+}][{}]|\||\n\n\n\n...xX......")).to eq("xx")
  end

  it "uses helper methods to clean the lines up" do
    # Similar to the tests above, these tests use "xx" as it walks through
    # the steps of translation
    expect(night_writer.make_array("~00|..|00~~00|..|00~")).to eq([["00", "..", "00"], ["00", "..", "00"]])
    expect(night_writer.array_to_text([["00", "..", "00"], ["00", "..", "00"]])).to eq(["00 00", ".. ..", "00 00"])
    expect(night_writer.split_lines_by_three(["00 00", ".. ..", "00 00"])).to eq(["00 00\n.. ..\n00 00"])
    # At the end of the clean_lines method (where these helpers are used), it
    # finally takes the text out of the array using .join
  end

  it "can clean up pre-translated text" do
    # This test is the complete version of the helpers above
    expect(night_writer.clean_lines("~00|..|00~~00|..|00~")).to eq("00 00\n.. ..\n00 00")
  end

end
