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
  expect(File.open(test_message.path).readlines).to eq(["nothing"])
  end
end
