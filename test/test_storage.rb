require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require_relative '../lib/storage'


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


  def test_load_from_file
    @storage.load_from_file './examples/load_from_file'
    assert_equal ['abc', 'abcd', 'abcde', 'asd', 'asdf', 'asdg', 'asdgh', 'xyz', 'qwe', 'qwer', 'qwert', 'qwery'], @storage.trie.find('')
  end


  def test_load_from_zip
    @storage.load_from_zip './examples/load_from_zip'
    assert_equal ['abc', 'abcd', 'abcde', 'asd', 'asdf', 'asdg', 'asdgh', 'xyz', 'qwe', 'qwer', 'qwert', 'qwery'], @storage.trie.find('')
  end


  def test_save_to_file
    @storage.save_to_file './examples/save_to_file'
    assert File.exist?('./examples/save_to_file.yaml')
  end


  def test_save_to_zip
    @storage.save_to_zip './examples/save_to_zip'
    assert File.exist?('./examples/save_to_zip.zip')
  end

end
