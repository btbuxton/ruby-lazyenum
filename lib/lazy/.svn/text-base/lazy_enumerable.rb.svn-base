###
### LazyEnumerable makes the implementation of higher order methods easier. LazyIterator
### is a simple implemetation of that. It basically works by "stacking" up the method
### calls until the collection needs to be calculated (realized). It then calls the
### "stacked up" methods.
###
### LazyEnumerable is immutable and I would like LazyIterator to be as well. But,
### every attempt has made the code ugly and inelegant. I'm still looking for a good
### solution. Immuntability gives the ability to calculate on different levels.
###
module Lazy
  
  class LazyEnumerable
    PLACEBO=lambda {|each| each}
    
    ##
    ## Remove any unnecessary methods so that method_missing is invoked
    ##
    def self.wack_all_my_methods
      to_wack = instance_methods.reject do |each|
        ['===','method_missing'].include?(each) || each =~ /^__/
      end
      to_wack.each do |each|
        alias_method("_#{each}", each)
        undef_method(each)
      end
    end
    
    def self.iterator_creator(*method_names)
      method_names.each { |every| iterator_creator_for(every) }
    end
    
    def self.iterator_creator_for(method_name)
      non_lazy_name = /lazy_(.+)/.match(method_name.to_s)[1].to_sym
      define_method(method_name) { LazyEnumerable.new(_method(non_lazy_name)) }
    end
    
    wack_all_my_methods
    include Enumerable
    iterator_creator :lazy_inject, :lazy_select, :lazy_collect, :lazy_reject, :lazy_detect, :lazy_each
    
    
    
    def initialize(proc)
      @internal=proc
      @sends=[]
    end
    
    ##
    ## Simply make a closure around the method and capturing it's arguments as well
    ## This is so it can be replayed. Notice again, I cache the method with a define_method
    ##
    def method_missing(method_name, *arguments)
      proc=lambda do |*args|
        send=lambda {|each| each.send(method_name, *args)}
        @sends << send
        self
      end
      self._class.send(:define_method, method_name, &proc)
      proc.call(*arguments)
    end
    
    def respond_to?(symbol,include_private = false)
      true
    end
    
    ##
    ## Do a placebo collect to get it to create an array with the elements
    ##
    def to_real
      collect(&PLACEBO)
    end
    
    ##
    ## Call each member in the original collection and call each "captured" method
    ## in succession. Notice the use of inject to make this really elegant and succint.
    ## I do cheat a little and realize the collection and then call each. I want
    ## to change this in the future. Actually, 1.9 will make this possible. We'll
    ## be able to use iterators and will make below more lazy.
    ##
    def each(&block)
      answer = @internal.call do |each|
        @sends.inject(each) do |result, each_send |
          each_send.call(result)
        end
      end
      answer.each(&block)
    end
    
    ##
    ## Give me the size. This can be dangerous if you ever wrap an infinite enumerable
    ##
    def size
      inject(0) {|sum,each| sum + 1 }
    end
    
    def to_lazy
      self
    end
    
  end
  
end