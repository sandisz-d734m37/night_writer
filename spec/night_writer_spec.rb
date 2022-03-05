require './lib/night_writer'
require 'tempfile'

RSpec.describe NightWriter do
  subject { NightWriter.new(arguments).readfile }

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
    subject
    expect(NightWriter.new(arguments)).to be_a NightWriter
  end

  it "can open a file" do
    subject
    expect(File.open(test_message.path).readlines).to eq(["nothing"])
  end

  it "can modify text and write to a file" do
    subject
    expect(File.open(test_braille.path).readlines).to eq(["NOTHING"])
  end

  it "can print to the terminal" do
    expect { subject }.to output("Created 'test_braille.txt' containing 7 characters").to_stdout
  end
end
