require File.dirname(__FILE__) + '/../spec_helper.rb'

describe Tickler::TaskAdapter do

  describe "self.register_as" do

    it "pushes the name into the registry" do
      lambda {Tickler::TaskAdapter.create(:foo)}.should raise_error

      class FooAdapter < Tickler::TaskAdapter
        register_as :foo
      end

      Tickler::TaskAdapter.create(:foo).should be_instance_of(FooAdapter)
    end

  end

  describe "self.get" do

    before { Tickler::TaskAdapter.set(nil) }

    it "raises if there is no adapter available" do
      lambda { Tickler::TaskAdapter.get }.
        should raise_error(Tickler::NoTaskAdapterError)
    end

  end

end
