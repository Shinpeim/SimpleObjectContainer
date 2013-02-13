require "simple-object-container"

describe SimpleObjectContainer do
  it "can be created" do
    SimpleObjectContainer.new.should be_instance_of SimpleObjectContainer
  end
end
