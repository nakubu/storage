require 'minitest/autorun'
require './storage'


class TestStorage < Minitest::Test
  def setup
    @storage = Storage.new 'abc,abcd,abcde,xyz'
  end


  def test_init_word_list
    assert_equal ['abc', 'abcd', 'abcde', 'xyz'], @storage.trie.find('')
  end


  def test_add_word
    @storage.add 'qwe'
    assert @storage.contains?('qwe')
  end


  def test_contains_word
    assert @storage.contains?('abc')
  end


  def test_not_contains_word
    refute @storage.contains?('abd')
  end


  def test_find_result_array
    assert_equal ['abc', 'abcd', 'abcde'], @storage.find('abc')
  end


  def test_find_empty_array
    assert_equal [], @storage.find('uvw')
  end


  def test_find_raise_argument_error
    assert_raises(ArgumentError) { @storage.find('uv') }
  end
end
