require "simple-object-container/version"
class SimpleObjectContainer
  def register(key, rest = nil)
    if key.class != Class && key.class !=Symbol
      raise ArgumentError,"key should be Class or Symbol"
    end

    if key.class == Class
      register_class_by_class(key)
    elsif key.class == Symbol && rest.class == Class
      register_class_by_symbol(key,rest)
    elsif key.class == Symbol && rest.class == Proc
      register_lambda_by_symbol(key,rest)
    else
      raise "assert"; #never reach here ;)
    end
  end
  def get(klass)
    get_instance(klass)
  end

  private
  def instance_table
    @instance_table ||= {}
  end
  def loader_table
    @loader_table ||= {}
  end

  def register_class_by_class(klass)
    register_loader(klass, ->(){klass.new})
  end
  def register_class_by_symbol(key,klass)
    register_loader(key, ->(){klass.new})
  end
  def register_lambda_by_symbol(key,lambda)
    register_loader(key, lambda)
  end
  def register_loader(key,loader)
    loader_table[key] = loader
  end

  def get_instance(key)
    return instance_table[key] if instance_table[key]

    loader = loader_table[key]
    raise KeyIsNotRegisterd if loader.nil?

    instance_table[key] ||= loader.call
    instance_table[key]
  end
end
class SimpleObjectContainer
  class Error < StandardError;end
  class KeyIsNotRegisterd < Error;end
end
