require 'yaml'
require 'zip'
require_relative 'trie'


class Storage
  attr_accessor :trie


  def initialize(string = '')
    @trie = Trie.new
    string.split(',').each { |word| @trie.add(word) }
  end


  def add(string)
    @trie.add(string)
  end


  def contains?(string)
    @trie.contains?(string) || false
  end


  def find(string)
    raise ArgumentError if string.size < 3
    @trie.find(string)
  end


  def load_from_file(filename)
    new_words = YAML.load_file(filename + '.yaml')
    new_words.each { |word| @trie.add(word) }
  end


  def load_from_zip(filename)
    new_words = []
    Zip::ZipFile.open(filename + '.zip') do |zipfile|
      zipfile.each do |file|
        content = file.get_input_stream.read
        new_words |= YAML.load(content)
      end
    end
    new_words.each { |word| @trie.add(word) }
  end


  def save_to_file(filename)
    words = @trie.find('')
    File.open(filename + '.yaml', 'w') { |f| YAML.dump(words, f) }
  end


  def save_to_zip(filename)
    words = @trie.find('')
    Zip::ZipFile.open(filename + '.zip', Zip::ZipFile::CREATE) do |zipfile|
      zipfile.get_output_stream(filename + '.yaml') { |f| YAML.dump(words, f) }
    end
  end
end
