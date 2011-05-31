require 'test/unit'
class LazyEnumerableTest < Test::Unit::TestCase
  
  def test_lazy
    original=(1..100)
    modified=original.to_lazy.select { |each| each % 2 == 0 }
    modified_even=modified
    modified=modified.reject { |each| (each % 4).zero? }
    modified=modified.collect { |each| each.to_s }
    modified=modified.select { |each| each.size == 1 }
    #force, the collection to be realized
    realized_collection=modified.to_real
    assert_equal(['2', '6'], realized_collection)
    assert_equal(50,modified_even.size)
    assert(modified_even.to_real.class != Lazy::LazyEnumerable)
  end
  
  def test_iterator
    original=(1..100)
    modified=original.to_lazy.lazy_select.even
    modified_even=modified
    modified=(modified.lazy_reject % 4).zero?
    modified=modified.lazy_collect.to_s
    modified=modified.select { |each| each.size == 1 }
    #force, the collection to be realized
    realized_collection=modified.to_real
    assert_equal(['2', '6'], realized_collection)
    assert_equal(50,modified_even.size)
    assert(modified_even.to_real.class != Lazy::LazyEnumerable)
  end
  
end

class Numeric
  def even
    self % 2 == 0
  end
end