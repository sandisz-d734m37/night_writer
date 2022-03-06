RSpec.describe NightWriter do
  let(:night_reader) { NightWriter.new(arguments) }

  let(:arguments) { [test_braille.path, test_og_message.path] }
  let(:test_og_message) { Tempfile.new('txt')}
  let(:test_braille) do
    Tempfile.new('txt').tap do |br_msg|
      br_msg << "00 00\n.. ..\n00 00"
      br_msg.close
    end
  end

  after do
    test_braille.unlink
    test_og_message.unlink
  end

  it "exists" do
    night_reader.readfile
    expect(night_writer).to be_a NightWriter
  end
end
