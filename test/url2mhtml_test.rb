require File.dirname(__FILE__) + '/test_helper.rb'

require "test/unit"
class Url2mhtmlTest < Test::Unit::TestCase
  def setup
  end

  def teardown
  end
  
  def test_capture
    result = Url2mhtml.capture('http://www.google.com')
    assert(result, "Failure.") 
  end
  
end
