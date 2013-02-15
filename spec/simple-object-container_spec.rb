require "spec_helper"
require "simple-object-container"

describe SimpleObjectContainer do
  describe "Object interface" do
    before do
      @container = SimpleObjectContainer.new
    end

    it "can be created" do
      @container.should be_instance_of SimpleObjectContainer
    end

    context "when SomeClass is registered" do
      before do
        @container.register(SomeClass)
      end
      describe "#get" do
        it "load object lazy" do
          @container.send(:instance_table)[SomeClass].should be_nil
          @container.get(SomeClass)
          @container.send(:instance_table)[SomeClass].should be_instance_of SomeClass
        end
        context "when given SomeClass with a class name" do
          subject {@container.get(SomeClass)}
          it "return a instance of SomeClass" do
            subject.should be_instance_of SomeClass
          end
          it "always return same object" do
            subject.should be_equal @container.get(SomeClass)
          end
        end
        context "when Given OtherClass" do
          it "should raise error if given no registerd class" do
            ->(){@container.get(OtherClass)}.should raise_error SimpleObjectContainer::KeyIsNotRegisterd
          end
        end
      end
    end

    context "when SomeClass is registered with a simbol(:key)" do
      before do
        @container.register(:key, SomeClass)
      end
      describe "#get" do
        it "load object lazy" do
          @container.send(:instance_table)[:key].should be_nil
          @container.get(:key)
          @container.send(:instance_table)[:key].should be_instance_of SomeClass
        end
        context "when given :key" do
          subject {@container.get(:key)}
          it "return a instance of SomeClass" do
            subject.should be_instance_of SomeClass
          end
          it "always return same object" do
            subject.should be_equal @container.get(:key)
          end
        end
        context "when Given OtherClass" do
          it "should raise error if given no registerd class" do
            ->(){@container.get(:other_key)}.should raise_error SimpleObjectContainer::KeyIsNotRegisterd
          end
        end
      end
    end

    context "when lambda(that return a instance of SomeClass) is registered with a simbol(:key)" do
      before do
        @container.register(:key, ->(){SomeClass.new})
      end
      describe "#get" do
        it "load object lazy" do
          @container.send(:instance_table)[:key].should be_nil
          @container.get(:key)
          @container.send(:instance_table)[:key].should be_instance_of SomeClass
        end
        context "when given :key" do
          subject {@container.get(:key)}
          it "return a instance of SomeClass" do
            subject.should be_instance_of SomeClass
          end
          it "always return same object" do
            subject.should be_equal @container.get(:key)
          end
        end
        context "when Given OtherClass" do
          it "should raise error if given no registerd class" do
            ->(){@container.get(:other_key)}.should raise_error SimpleObjectContainer::KeyIsNotRegisterd
          end
        end
      end
    end
  end
end
