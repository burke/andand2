# possibly-better-but-at-least-different version of andand. 
# myObject.andand.method.garbage.method.garbage.garbage.garbage.method.method.garbage 
# ... works, unlike with the standard andand.

class Object
  def andand
    AndAnd.new(self)
  end
end

class AndAnd

  (instance_methods-["__id__","__send__"]).each do |meth|
    eval("undef #{meth.to_s}")
  end

  @@and_and_nil = nil
  def @@and_and_nil.method_missing(sym, *args)
    @@and_and_nil
  end

  def inspect
    @_obj.inspect
  end
  
  def initialize(contents)
    @_obj = contents
  end

  def method_missing(sym, *args)
    if @_obj.respond_to?(sym)
      AndAnd.new(@_obj.send(sym, *args))
    else 
      AndAnd.new(@@and_and_nil)
    end
  end

  def self.unbind(andanded)
    x = andanded.instance_eval("@_obj")
    x == @@and_and_nil ? nil : x
  end
  
end
