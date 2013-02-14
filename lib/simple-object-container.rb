require "simple-object-container/version"
class SimpleObjectContainer
  def register(key, klass = nil)
    if key.class != Class && key.class !=Symbol
      raise ArgumentError,"key should be Class or Symbol"
    end

    if key.class == Class
      register_class_by_class(key)
    elsif key.class == Symbol
      register_class_by_symbol(key,klass)
    else
      raise "assert"; #never reach here ;)
    end
  end

  def get(klass)
    get_instance(klass)
  end

  private
  def register_class_by_class(klass)
    set_instance_to_instance_table(klass, klass.new)
  end
  def register_class_by_symbol(key,klass)
    set_instance_to_instance_table(key, klass.new)
  end

  def get_instance(klass)
    instance = @instance_table[klass.__id__]
    raise KeyIsNotRegisterd if instance.nil?
    return instance
  end
  def set_instance_to_instance_table(klass, instance)
    @instance_table ||= {}
    @instance_table[klass.__id__] = instance
  end
end
class SimpleObjectContainer
  class Error < StandardError;end
  class KeyIsNotRegisterd < Error;end
end
