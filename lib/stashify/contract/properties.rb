# frozen_string_literal: true

require "rantly/rspec_extensions"

class Rantly
  def path
    File.join(*array { file_name })
  end

  def file_name
    string(%r{[[:print:]&&[^/]]})
  end
end
