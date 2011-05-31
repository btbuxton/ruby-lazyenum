###
### Hack to get the current method off the stack. I hate this.
### Why can't I reflect on the stack and get the real method 
### invocation? Grrr...
###
module Kernel
  
  private
  def current_method
    (caller[0] =~ /`([^']*)'/ and $1).to_sym
  end
  
end

###
### Conversion methods
###
module Enumerable
  
  def to_lazy
    Lazy::LazyEnumerable.new(self.method(:collect))
  end
  
  def to_real
    self
  end
  
end