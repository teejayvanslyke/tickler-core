require File.dirname(__FILE__) + '/../spec_helper.rb'

describe Tickler::Ticket do

  describe "Ticket.create" do

    before(:each) do
      @adapter = mock('connection adapter')
      @adapter.stub!(:save_ticket)
      Tickler::TaskAdapter.stub!(:get).and_return(@adapter)
    end

    it "sets attributes" do
      @ticket = Tickler::Ticket.create(:title => 'some title')
      @ticket.attributes[:title].should == 'some title'
    end

    it "saves the ticket to the repository" do
      @ticket = mock(Tickler::Ticket)
      Tickler::Ticket.stub!(:new).and_return(@ticket)

      @adapter.should_receive(:save_ticket).
        with(@ticket)
      Tickler::Ticket.create(:title => 'some title')
    end

  end

end

