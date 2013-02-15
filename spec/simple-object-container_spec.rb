require "spec_helper"
require "simple-object-container"

class SimpleObjectContainer
  module Containable
    def clear
      @instance_table = {}
      @loader_table = {}
    end
  end
end
shared_examples_for "SimpleObjectContainer behavior" do
  context "when SomeClass is registered" do
    before do
      subject.register(SomeClass)
    end
    after do
      subject.clear
    end
    describe "#get" do
      it "load object lazy" do
        subject.send(:instance_table)[SomeClass].should be_nil
        subject.get(SomeClass)
        subject.send(:instance_table)[SomeClass].should be_instance_of SomeClass
      end
      context "when given SomeClass with a class name" do
        let(:returned_value) {subject.get(SomeClass)}
        it "return a instance of SomeClass" do
          returned_value.should be_instance_of SomeClass
        end
        it "always return same object" do
          returned_value.should be_equal subject.get(SomeClass)
        end
      end
      context "when Given OtherClass" do
        it "should raise error if given no registerd class" do
          ->(){subject.get(OtherClass)}.should raise_error SimpleObjectContainer::KeyIsNotRegisterd
        end
      end
    end
  end

  context "when SomeClass is registered with a simbol(:key)" do
    before do
      subject.register(:key, SomeClass)
    end
    after do
      subject.clear
    end
    describe "#get" do
      it "load object lazy" do
        subject.send(:instance_table)[:key].should be_nil
        subject.get(:key)
        subject.send(:instance_table)[:key].should be_instance_of SomeClass
      end
      context "when given :key" do
        let (:returned_value) {subject.get(:key)}
        it "return a instance of SomeClass" do
          returned_value.should be_instance_of SomeClass
        end
        it "always return same object" do
          returned_value.should be_equal subject.get(:key)
        end
      end
      context "when Given OtherClass" do
        it "should raise error if given no registerd class" do
          ->(){subject.get(:other_key)}.should raise_error SimpleObjectContainer::KeyIsNotRegisterd
        end
      end
    end
  end

  context "when lambda(that return a instance of SomeClass) is registered with a simbol(:key)" do
    before do
      subject.register(:key, ->(){SomeClass.new})
    end
    after do
      subject.clear
    end
    describe "#get" do
      it "load object lazy" do
        subject.send(:instance_table)[:key].should be_nil
        subject.get(:key)
        subject.send(:instance_table)[:key].should be_instance_of SomeClass
      end
      context "when given :key" do
        let(:returned_value) {subject.get(:key)}
        it "return a instance of SomeClass" do
          returned_value.should be_instance_of SomeClass
        end
        it "always return same object" do
          returned_value.should be_equal subject.get(:key)
        end
      end
      context "when Given OtherClass" do
        it "should raise error if given no registerd class" do
          ->(){subject.get(:other_key)}.should raise_error SimpleObjectContainer::KeyIsNotRegisterd
        end
      end
    end
  end
end

describe "Singleton Interface" do
  subject {SimpleObjectContainer}
  it_should_behave_like "SimpleObjectContainer behavior"
end

describe "Object Interface" do
  subject {SimpleObjectContainer.new}
  it_should_behave_like "SimpleObjectContainer behavior"
end
