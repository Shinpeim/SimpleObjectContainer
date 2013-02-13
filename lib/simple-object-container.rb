require "simple-object-container/version"
class SimpleObjectContainer
  def register(klass)
    set_instance_to_instance_table(klass, klass.new)
  end

  def get(klass)
    get_instance(klass)
  end

  private
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
