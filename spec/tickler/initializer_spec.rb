require File.dirname(__FILE__) + '/../spec_helper.rb'

describe Tickler::Initializer do

  describe "run" do

    it "evaluates the block it is passed on itself" do
      Tickler::Initializer.should_receive(:class_eval)
      Tickler::Initializer.run { false }
    end

  end

  describe "task_adapter" do

    before { Tickler::TaskAdapter.set(nil) }

    it "creates a new task adapter from the registry" do
      Tickler::TaskAdapter.should_receive(:set).with(:trac)
      Tickler::Initializer.run { task_adapter(:trac) {} }
    end

    it "evaluates the block it is passed on the task adapter" do
      @task_adapter = mock('task adapter')
      Tickler::TaskAdapter.stub!(:set).and_return(@task_adapter)
      @task_adapter.should_receive(:instance_eval)

      Tickler::Initializer.run { task_adapter(:trac) }
    end

    it "sets the current task adapter to this one" do
      lambda {Tickler::TaskAdapter.get}.
        should raise_error

      @task_adapter = mock('task adapter')
      Tickler::TaskAdapter.stub!(:create).and_return(@task_adapter)
      @task_adapter.should_receive(:instance_eval)

      Tickler::Initializer.run { task_adapter(:trac) }
      Tickler::TaskAdapter.get.should == @task_adapter
    end
  end

end

