require File.dirname(__FILE__) + '/test_helper.rb'
ActiveRecord::Base.establish_connection(YAML::load(File.read(File.dirname(__FILE__) + '/../config/database.yml')))

class TestEntityStorage < Test::Unit::TestCase
  DEFAULT_KEYS = { "test" => DateTime.parse("1-1-900"), "also test" => 2, "long ass key that I probably wouldn't use" => false,
	# last time the hiring manager notifications have been run 
  "new_applicant_last_run" => DateTime.parse("1-1-1900"),
  # last time the new job notifications have been run 
  "new_jobs_last_run" => DateTime.parse("1-1-1900"),
  "email_test_address" => "joshuas@bnj.com" }
  
  attr_accessor :EntityStore
	EntityStore = EntityStorage::Storage.new(DEFAULT_KEYS)
	
  def setup
    ActiveRecord::Base.connection.execute("delete from entity_storage")
  end
  
  def test_instantiation
		# test nasty weird bug with underscore characters
		entityStore2 = EntityStorage::Storage.new(DEFAULT_KEYS)
		assert_equal entityStore2.email_test_address, 'joshuas@bnj.com'
  end
  
  # tests value setting and getting functionality, along with default creation  
  def test_defaultkeys
    DEFAULT_KEYS.each { |key,value| 
      EntityStore.delete(key)
      
      # set key when it doesn't exist, should go to default
      e = EntityStore[key]
      assert_equal e, value
      
      EntityStore.delete(key)
      
      # set and try method missing access
      if key[/\w/] == key
				eval("e = EntityStore."+key)
				assert_equal e, value
			end
      
      # change it to something else
      EntityStore[key] = Time.now.to_s
      e = EntityStore[key]
      assert_not_equal e, value
      
      # find out it's default
      e = EntityStore.default(key)
      assert_equal e, value
      
      e = EntityStore.defaults[key]
      assert_equal e, value
      
      # set it back to default
      EntityStore.default!(key)
      e = EntityStore[key]
      assert_equal e, value
      
      # set it to something else using method missing
      if key[/\w/] == key
				eval("e = EntityStore."+key +" = Time.now.to_s")
				assert_equal e, value
      end 
    }
  end
  
  # tests setting values when no DEFAULT_KEY exists
  def test_settingvalues
    EntityStore.delete('test')
    
    # key that can't be accessed via method missing
    # set value and check it
    EntityStore['big long key that cannot be accessed via method missing'] = 'what up'
    e = EntityStore['big long key that cannot be accessed via method missing']
    assert_equal e, 'what up'
    
    # set another value and check it
    EntityStore['big long key that cannot be accessed via method missing'] = 'another value'
    e = EntityStore['big long key that cannot be accessed via method missing']
    assert_equal e, 'another value'
    
    EntityStore['test'] = 'what up'
    e = EntityStore['test']
    assert_equal e, 'what up'
    
    EntityStore['test'] = 'another value'
    e = EntityStore['test']
    assert_equal e, 'another value'
    
    # try the method missing version of the tests
    e = EntityStore.test = 'what up'
    e = EntityStore.test
    assert_equal e, 'what up'
    
    e = EntityStore.test = 'another value'
    e = EntityStore.test
    assert_equal e, 'another value'
    
  end
  
  def test_getunknownvalue
    EntityStore.delete('does not exist')
    e = EntityStore['does not exist']
    assert_nil e
  end
  
end
