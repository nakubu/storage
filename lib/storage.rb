require 'yaml'
require 'zip'


class Trie
  attr_accessor :level, :hash


  def initialize(level = 0)
    @level = level
    @hash = Hash.new
  end


  def add(string)
    letter = this_letter(string)
    if letter.nil?
      @hash[letter] = string
    else
      trie = @hash[letter]
      if trie.nil?
        trie = @hash[letter] = Trie.new(@level + 1)
      end
      trie.add(string)
    end
  end


  def find(string)
    @found_words = []
    hash = begin?(string)
    find_recursive(hash)
    @found_words
  end


  def begin?(string)
    letter = this_letter(string)
    if letter.nil?
      @hash
    else
      trie = @hash[letter]
      trie && trie.begin?(string)
    end
  end


  def contains?(string)
    letter = this_letter(string)
    if letter.nil?
      @hash[nil] == string
    else
      trie = @hash[letter]
      trie && trie.contains?(string)
    end
  end


  protected


  def find_recursive(hash)
    return unless hash
    hash.each do |key, value|
      if key.nil?
        @found_words << value
      else
        find_recursive(value.hash)
      end
    end
  end


  def this_letter(string)
    letter = string[@level, 1]
    letter && letter.empty? ? nil : letter
  end
end


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
    Zip::File.open(filename + '.zip') do |zipfile|
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
    Zip::File.open(filename + '.zip', Zip::File::CREATE) do |zipfile|
      zipfile.get_output_stream(filename + '.yaml') { |f| YAML.dump(words, f) }
    end
  end
end
