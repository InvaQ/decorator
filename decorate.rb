
module Decorators
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def add_prefix(prefix)
      @prefix = prefix
      @call = true
    end
    
    def method_added(method)  
      return unless @first_call
      prefix = @prefix
      @fcall = false
      alias_method "real_#{method}", method
      define_method method do |*args, &block|
        prefix + send("real_#{method}", *args, &block)
      end
    end
  end

end
class C
  include Decorators

  add_prefix('hello ')
  def a
    'from a'
  end
  add_prefix('hello ')
  def b
    'from b'
  end

end


puts C.new.a
puts C.new.b
