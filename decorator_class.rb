require_relative 'decorator'

class C
  include Decorators

  add_prefix('hello ')
  def a
    'from a'
  end

  def b
    'from b'
  end

end


puts C.new.a
puts C.new.b
