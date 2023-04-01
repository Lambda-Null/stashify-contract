# frozen_string_literal: true

require "stashify/properties"

RSpec.shared_context "file setup" do |property_count|
  around(:each) do |s|
    property_of { [path, string] }.check(property_count) do |path, contents|
      @path = path
      @contents = contents
      s.run
    end
  end

  let(:path) { @path }
  let(:contents) { @contents }
  let(:property_count) { property_count }
end

RSpec.shared_examples "a file" do
  it "sets the name" do
    expect(subject.name).to eq(File.basename(path))
  end

  it "reads the contents" do
    expect(subject.contents).to eq(contents)
  end

  it "writes new contents" do
    property_of { file_name }.check(property_count) do |new_contents|
      subject.write(new_contents)
      expect(subject.contents).to eq(new_contents)
    end
  end

  it "deletes the file" do
    expect(subject.exists?).to be_truthy
    subject.delete
    expect(subject.exists?).to be_falsey
  end
end
