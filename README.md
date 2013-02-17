# SimpleObjectContainer

SimpleObjectContainer is a gem like Object::Container Perl module(http://search.cpan.org/~typester/Object-Container-0.14/lib/Object/Container.pm)

## Installation

    $ gem install simple-object-container

## Usage

    # register Class by class name
    SimpleObjectCotainer.register(MyClass)
    # then, you can get a instance
    SimpleObjectContainer.get(MyClass) # => the instance of MyClass
	# and always return *the same* instance
	SimpleObjectContainer.get(MyClass).equal_to? SimpleObjectContaner.get(MyClass) # =>  true

    # you can register Class with a symbol as a key
    SimpleObjectContainer.register(:key, AnotherClass)
    # and you can get a instance using the key
    SimpleObjectContainer.get(:key)  # => the instance of AnotherClass
	# and always return *the same* instance
	SimpleObjectContainer.get(:key).equal_to? SimpleObjectContaner.get(:key) # =>  true
    
    # you can register a lambda which return a object you want
    SimpleObjectContainer.register(:key, lambda{ SomeClass.new(parameters) })
    # and you can get a instance which is returned by the lambda
    SimpleObjectContainer.get(:key) # =>  the instance of SomeClass initialized with parameters
	# and always return *the same* instance
	SimpleObjectContainer.get(:key).equal_to? SimpleObjectContaner.get(:key) # =>  true

SimpleObjectContainer has singleton interface like avobe and object interface like bellow.

    container = SimpleObjectCotainer.new
    container.register(MyClass)

	# you can use object interface by same way to singleton interface
    container.get(MyClass) # => the instance of MyClass
	# and always return *the same* instance
	container.get(MyClass).equal_to? container.get(MyClass) # =>  true

    another_container = SimpleObjectCotainer.new
    another_container.register(MyClass)
    container.get(MyClass).equal_to? another_container.get(MyClass) # =>  false


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
