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
      return unless @call
      prefix = @prefix
      @call = false
      alias_method "real_#{method}", method
      define_method method do |*args, &block|
        prefix + send("real_#{method}", *args, &block)
      end
    end
  end

end