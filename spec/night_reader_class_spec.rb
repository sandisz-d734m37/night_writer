require 'pry'
require './lib/night_reader_class'
RSpec.describe NightReader do
  let(:night_reader) { NightReader.new(arguments) }

  let(:arguments) { [test_braille.path, test_og_message.path] }
  let(:test_og_message) { Tempfile.new('txt')}
  let(:test_braille) do
    Tempfile.new('txt').tap do |br_msg|
      br_msg << "00\n..\n00"
      br_msg.close
    end
  end

  after do
    test_braille.unlink
    test_og_message.unlink
  end

  it "exists" do
    night_reader.readfile
    expect(night_reader).to be_a NightReader
  end

  it "can open a file" do
    night_reader.readfile
    expect(File.open(test_braille.path).readlines).to eq(["00\n", "..\n", "00"])
  end

  it "can write to a file" do
    night_reader.readfile
    expect(File.open(test_og_message.path).readlines).to eq(["x"])
  end

  it "can count characters in the message file print to the terminal" do
    night_reader.readfile
    expect{ night_reader.print_to_terminal }.to output("Created file '#{ARGV[1]}' containing 1 characters\n").to_stdout
  end

  it "will print to the terminal when it runs" do
    expect { night_reader.readfile }.to output("Created file '#{ARGV[1]}' containing 1 characters\n").to_stdout
  end
end

describe  "Untranslatable" do
  let(:night_reader) { NightReader.new(arguments) }

  let(:arguments) { [test_braille.path, test_og_message.path] }
  let(:test_og_message) { Tempfile.new('txt')}
  let(:test_braille) do
    Tempfile.new('txt').tap do |br_msg|
      br_msg << "00\n..\n00"
      br_msg.close
    end
  end

  after do
    test_braille.unlink
    test_og_message.unlink
  end

  it "can translate braille to regular english" do
    night_reader.readfile
    expect(File.open(test_og_message.path).readlines).to eq(["x"])
  end

  it "has helper methods" do
    expect(night_reader.clean_lines("00 00\n.. ..\n00 00")).to eq(["00|..|00", "00|..|00"])
    expect(night_reader.translate_from_braille("00 00\n.. ..\n00 00")).to eq("xx")
  end

  it "has helper methods for it's hlper methods" do
    expect(night_reader.prep_text("00 00\n.. ..\n00 00")).to eq(["00 00", ".. ..", "00 00"])
    expect(night_reader.split_transpose_join(["00 00", ".. ..", "00 00"])).to eq(["00|..|00", "00|..|00"])
  end

  it "can also remove unwanted characters" do
    expect(night_reader.remove_unwanted_char("1234567890*&^%${@!<>?,./-=_+AbcDEfGh")).to eq("abcdefgh")
  end
end
