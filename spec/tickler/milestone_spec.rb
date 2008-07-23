require File.dirname(__FILE__) + '/../spec_helper.rb'

describe Tickler::Milestone do

  describe "Milestone.create" do

    before(:each) do
      @adapter = mock('connection adapter')
      @adapter.stub!(:save_ticket)
      Tickler::TaskAdapter.stub!(:get).and_return(@adapter)
    end

    it "sets attributes" do
      @ticket = Tickler::Ticket.create(:title => 'some title')
      @ticket.attributes[:title].should == 'some title'
    end

    it "saves the milestone to the repository" do
      @milestone = mock(Tickler::Milestone)
      Tickler::Milestone.stub!(:new).and_return(@milestone)

      @adapter.should_receive(:save_milestone).
        with(@milestone)
      Tickler::Milestone.create(:title => 'some title')
    end

  end

  describe "Milestone.find" do
    before(:each) do
      @adapter = mock('connection adapter')
      Tickler::TaskAdapter.stub!(:get).and_return(@adapter)

      @milestones = 
        [
          mock(Tickler::Milestone, :title => 'foo'),
          mock(Tickler::Milestone, :title => 'bar')
        ]
    end


    describe "(:all)" do
      it "finds all milestones in the repository" do
        @adapter.should_receive(:find_milestones).
          with(:all).
          and_return(@milestones)
        result = Tickler::Milestone.find(:all)
        result.should == @milestones
      end
    end
  end

end

