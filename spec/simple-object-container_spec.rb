require "spec_helper"
require "simple-object-container"

describe SimpleObjectContainer do
  describe "Object interface" do
    let (:container) { SimpleObjectContainer.new }
    it "can be created" do
      container.should be_instance_of SimpleObjectContainer
    end

    context "when SomeClass is registered" do
      before do
        container.register(SomeClass)
      end
      describe "#get" do
        context "given SomeClass"
        it "return a instance of SomeClass" do
          container.get(SomeClass).should be_instance_of SomeClass
        end
        it "always return same object" do
          container.get(SomeClass).should be_equal container.get(SomeClass)
        end
        it "should raise error if given no registerd class" do
          ->(){container.get(OtherClass)}.should raise_error SimpleObjectContainer::KeyIsNotRegisterd
        end
      end
    end
  end
end
