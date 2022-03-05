require './lib/night_writer'
require 'tempfile'

RSpec.describe NightWriter do
  let(:night_writer) { NightWriter.new(arguments).readfile }

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
    night_writer
    expect(NightWriter.new(arguments)).to be_a NightWriter
  end

  it "can open a file" do
    night_writer
    expect(File.open(test_message.path).readlines).to eq(["nothing"])
  end

  it "can modify text and write to a file" do
    night_writer
    expect(File.open(test_braille.path).readlines.length).to eq(3)
  end

  it "can print to the terminal" do
    expect { night_writer }.to output("Created file '#{ARGV[1]}' containing 62 characters\n").to_stdout
  end

  it "can count characters in the new file" do
    spec_writer = NightWriter.new(arguments)
    spec_writer.readfile
    expected = spec_writer.count_characters(test_braille)
    # binding.pry
    expect expected == 63
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
end
