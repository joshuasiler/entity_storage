require File.dirname(__FILE__) + '/test_helper.rb'

class TestEntityStorage < Test::Unit::TestCase
  DEFAULT_KEYS = { "test" => DateTime.parse("1-1-900"), "also test" => 2, "long ass key that I probably wouldn't use" => false,
	# last time the hiring manager notifications have been run 
  "new_applicant_last_run" => DateTime.parse("1-1-1900"),
  # last time the new job notifications have been run 
  "new_jobs_last_run" => DateTime.parse("1-1-1900"),
  "email_test_address" => "joshuas@bnj.com" }
  
  attr_accessor :EntityStore
  
  def setup
    ActiveRecord::Base.establish_connection(YAML::load(File.read(File.dirname(__FILE__) + '/../config/database.yml'))) unless ActiveRecord::Base.connected?
    ActiveRecord::Base.connection.execute("delete from entity_storage")
    EntityStore = EntityStorage::Storage.new(DEFAULT_KEYS) if EntityStore.nil?
  end
  
  # tests value setting and getting functionality, along with default creation  
  def test_defaultkeys
    DEFAULT_KEYS.each { |key,value| 
      self.EntityStore.delete(key)
      
      # set key when it doesn't exist, should go to default
      e = self.EntityStore[key]
      assert_equal e, value
      
      self.EntityStore.delete(key)
      
      # set and try method missing access
      if key[/\w/] == key
				eval("e = self.EntityStore."+key)
				assert_equal e, value
			end
      
      # change it to something else
      self.EntityStore[key] = Time.now.to_s
      e = self.EntityStore[key]
      assert_not_equal e, value
      
      # find out it's default
      e = self.EntityStore.default(key)
      assert_not_equal e, value
      
      # set it back to default
      self.EntityStore.default!(key)
      e = self.EntityStore[key]
      assert_equal e, value
      
      # set it to something else using method missing
      if key[/\w/] == key
				eval("e = self.EntityStore."+key +" = Time.now.to_s")
				eval("e = self.EntityStore."+key)
				assert_equal e, value
      end 
    }
  end
  
  # tests setting values when no DEFAULT_KEY exists
  def test_settingvalues
    self.EntityStore.delete('test')
    
    # key that can't be accessed via method missing
    # set value and check it
    self.EntityStore['big long key that cannot be accessed via method missing'] = 'what up'
    e = self.EntityStore['big long key that cannot be accessed via method missing']
    assert_equal e, 'what up'
    
    # set another value and check it
    self.EntityStore['big long key that cannot be accessed via method missing'] = 'another value'
    e = self.EntityStore['big long key that cannot be accessed via method missing']
    assert_equal e, 'another value'
    
    self.EntityStore['test'] = 'what up'
    e = self.EntityStore['test']
    assert_equal e, 'what up'
    
    self.EntityStore['test'] = 'another value'
    e = self.EntityStore['test']
    assert_equal e, 'another value'
    
    # try the method missing version of the tests
    e = self.EntityStore.test = 'what up'
    e = self.EntityStore.test
    assert_equal e, 'what up'
    
    e = self.EntityStore.test = 'another value'
    e = self.EntityStore.test
    assert_equal e, 'another value'
    
  end
  
  def test_getunknownvalue
    self.EntityStore.delete('does not exist')
    e = self.EntityStore['does not exist']
    assert_nil e
  end
  
end
