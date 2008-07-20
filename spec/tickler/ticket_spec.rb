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

    it "has methods for accessing each attribute" do
      @ticket = Tickler::Ticket.create(:title => 'some title', 
                                       :priority => 'high')
      @ticket.title.should == 'some title'
      @ticket.priority.should == 'high'
    end

    it "saves the ticket to the repository" do
      @ticket = mock(Tickler::Ticket)
      Tickler::Ticket.stub!(:new).and_return(@ticket)

      @adapter.should_receive(:save_ticket).
        with(@ticket)
      Tickler::Ticket.create(:title => 'some title')
    end

  end

  describe "Ticket.find_all_open" do

    before(:each) do
      @adapter = mock('connection adapter')
      @adapter.stub!(:find_all_open)
      Tickler::TaskAdapter.stub!(:get).and_return(@adapter)

      @tickets = 
        [
          mock(Tickler::Ticket, :title => 'foo'),
          mock(Tickler::Ticket, :title => 'bar')
        ]
    end

    it "pulls all open tickets from the repository" do
      @adapter.should_receive(:find_tickets).
        with(:all, :status => 'open').
        and_return(@tickets)
      result = Tickler::Ticket.find(:all, :status => 'open')
      result.should == @tickets
    end

  end

end

