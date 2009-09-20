require File.dirname(__FILE__) + '/test_helper.rb'

class TestEntityStorage < Test::Unit::TestCase
  DEFAULT_KEYS = { "test" => DateTime.parse("1-1-900"), "also test" => 2, "long ass key that I probably wouldn't use" => false }
  attr_accessor :entity_storage
  
  def setup
    ActiveRecord::Base.establish_connection(YAML::load(File.read(File.dirname(__FILE__) + '/../config/database.yml'))) unless ActiveRecord::Base.connected?
    self.entity_storage ||= EntityStorage::Storage.new(DEFAULT_KEYS) 
  end
  
  # tests value setting and getting functionality, along with default creation  
  def test_defaultkeys
    DEFAULT_KEYS.each { |key,value| 
      self.entity_storage.delete(key)
      
      # set key when it doesn't exist, should go to default
      e = self.entity_storage[key]
      assert_equal e, value
      
      # set and try method missing access
      if key[/\w/] == key
	eval("e = self.entity_storage."+key)
	assert_equal e, value
      end
      
      # change it to something else
      self.entity_storage[key] = Time.now.to_s
      e = self.entity_storage[key]
      assert_not_equal e, value
      
      # find out it's default
      e = self.entity_storage.default(key)
      assert_not_equal e, value
      
      # set it back to default
      self.entity_storage.default!(key)
      e = self.entity_storage[key]
      assert_equal e, value
      
      # set it to something else using method missing
      if key[/\w/] == key
	eval("e = self.entity_storage."+key +" = Time.now.to_s")
	eval("e = self.entity_storage."+key)
	assert_equal e, value
      end 
    }
  end
  
  # tests setting values when no DEFAULT_KEY exists
  def test_settingvalues
    self.entity_storage.delete('test')
    
    # key that can't be accessed via method missing
    # set value and check it
    self.entity_storage['big long key that cannot be accessed via method missing'] = 'what up'
    e = self.entity_storage['big long key that cannot be accessed via method missing']
    assert_equal e, 'what up'
    
    # set another value and check it
    self.entity_storage['big long key that cannot be accessed via method missing'] = 'another value'
    e = self.entity_storage['big long key that cannot be accessed via method missing']
    assert_equal e, 'another value'
    
    self.entity_storage['test'] = 'what up'
    e = self.entity_storage['test']
    assert_equal e, 'what up'
    
    self.entity_storage['test'] = 'another value'
    e = self.entity_storage['test']
    assert_equal e, 'another value'
    
    # try the method missing version of the tests
    e = self.entity_storage.test = 'what up'
    e = self.entity_storage.test
    assert_equal e, 'what up'
    
    e = self.entity_storage.test = 'another value'
    e = self.entity_storage.test
    assert_equal e, 'another value'
    
  end
  
  def test_getunknownvalue
    self.entity_storage.delete('does not exist')
    e = self.entity_storage['does not exist']
    assert_nil e
  end
  
end
