# frozen_string_literal: true

require "stashify/properties"

RSpec.shared_context "directory setup" do |property_count|
  around(:each) do |s|
    property_of { [path, file_name, string] }.check(property_count) do |path, file_name, contents|
      @path = path
      @file_name = file_name
      @contents = contents
      s.run
    end
  end

  let(:path) { @path }
  let(:file_name) { @file_name }
  let(:contents) { @contents }
  let(:property_count) { property_count }
end

RSpec.shared_examples "a directory" do
  it "sets the name" do
    expect(subject.name).to eq(File.basename(path))
  end

  it "reads a file" do
    expect(subject.find(file_name)).to eq(Stashify::File.new(name: file_name, contents: contents))
  end

  it "reads a directory" do
    expect(subject.parent.find(File.basename(path))).to eq(subject)
  end

  it "deletes and writes a file" do
    expect(subject.exists?(file_name)).to be_truthy
    subject.delete(file_name)
    expect(subject.exists?(file_name)).to be_falsey
    file = Stashify::File.new(name: file_name, contents: contents)
    subject.write(file)
    expect(subject.find(file_name)).to eq(file)
  end

  it "writes and deletes a directory" do
    subject.delete(file_name)
    file = Stashify::File.new(name: file_name, contents: contents)
    subject.write(Stashify::Directory.new(
                    name: file_name,
                    files: [file],
                  ))
    expect(subject.directory?(file_name)).to be_truthy
    expect(subject.find(file_name).find(file_name)).to eq(file)
    subject.delete(file_name)
    expect(subject.directory?(file_name)).to be_falsey
  end

  it "returns nil when file doesn't exist" do
    subject.delete(file_name)
    expect(subject.find(file_name)).to be_nil
  end
end
