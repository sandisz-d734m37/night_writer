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
end
