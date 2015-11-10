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
