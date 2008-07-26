require File.dirname(__FILE__) + '/../spec_helper.rb'

describe Tickler::Util do

  before(:each) { Tickler::Util.stub!(:load_config) }

  describe "run" do

    describe "load_config" do
      describe "with no valid Ticklerfile" do
        before do
          Tickler::Util.stub!(:load_config).
            and_raise(LoadError)
        end

        it "notifies the user that no Ticklerfile could be found" do
          Tickler::Util.should_receive(:error).
            with("No Ticklerfile in this directory.  Run 'tickler init' "+
                 "to create a brand-spankin' new template file in your working directory.")
          Tickler::Util.run nil
        end
      end
    end


    describe "no arguments" do

      it "lists usage" do
        Tickler::Util.should_receive(:print_usage)
        Tickler::Util.run nil
      end

    end

    describe "command aliases" do
      it "allows 'ls' in place of 'list'" do
        Tickler::Util.should_receive(:list)
        Tickler::Util.run [ 'ls' ]
      end
    end

    describe 'info' do

      describe "no arguments" do
        it "displays help for command" do
          Tickler::Util.should_receive(:print_usage).
            with('info')
          Tickler::Util.run [ 'info' ]
        end
      end

      describe 'ticket' do

        describe "with valid ticket ID" do
          before(:each) do
            @ticket = mock(Tickler::Ticket, :id => 345,
                           :title => 'A Sample Ticket',
                           :attributes => {})
            Tickler::Ticket.stub!(:find).
              with('345').
              and_return(@ticket)
          end

          it "loads the ticket" do
            Tickler::Ticket.should_receive(:find).
              with('345').
              and_return(@ticket)
            Tickler::Util.run [ 'info', 'ticket', '345' ]
          end

          it "displays the data" do
            Tickler::Util.should_receive(:print_ticket_info).
              with(@ticket)
            Tickler::Util.run [ 'info', 'ticket', '345' ]
          end
        end

        describe "with no ticket id" do
          it "displays help for command" do
            Tickler::Util.should_receive(:print_usage).
              with('info')
            Tickler::Util.run [ 'info', 'ticket' ]
          end
        end

        describe "with invalid ticket ID" do
          it "prints an error" 
        end

      end
      describe 'milestone'
      
    end

    describe "create" do
      
      describe "ticket" do

        describe "with no attributes specified at all" do

          it "informs the user they need a title" do
            Tickler::Util.should_receive(:error).
              with("You need to specify a title for your ticket.\n" + 
                   "For instance:\n"+
                   "\ttickler create ticket \"As a user, I want to " +
                   "take over the world so I don't have to work anymore.\"")
            Tickler::Util.run ['create', 'ticket']
          end

        end

        describe "with title only" do

          it "creates a new ticket with title only" do
            Tickler::Ticket.should_receive(:create).
              with(:title => 'my title')

            Tickler::Util.run ['create', 'ticket', 'my title']
          end

        end

        describe "with title and attributes" do

          it "creates a new ticket with multiple attributes" do
            Tickler::Ticket.should_receive(:create).
              with(:title => 'my title',
                   :severity => '10')

            Tickler::Util.run ['create', 'ticket', 'my title', 'severity:10']
          end

        end

      end

        
      describe "milestone" do

        describe "with no arguments" do
          it "displays an error"
        end

        describe "with title only" do
          it "creates a new milestone" do
            Tickler::Milestone.should_receive(:create).
              with(:title => "my title")
            Tickler::Util.run ['create', 'milestone', 'my title']
          end
        end

      end

    end

    describe "init" do
      it "copies the template Ticklerfile to the current working directory"
    end
        

    describe "list" do

      describe "with no arguments" do
        describe "with current milestone set" do
          it "lists tickets in the current milestone"
        end

        describe "with no current milestone set" do
          before(:each) do 
            @tickets = 
              [
                mock(Tickler::Ticket, :id => 1, :title => "Ticket1 Title"),
                mock(Tickler::Ticket, :id => 2, :title => "Ticket2 Title"),
                mock(Tickler::Ticket, :id => 3, :title => "Ticket3 Title")
              ]
            Tickler::Ticket.stub!(:find).and_return(@tickets)
          end
                                                             
          it "lists all open tickets, sorted by milestone (where applicable)" do
            Tickler::Util.should_receive(:print_row).with(:id => 1, :title => "Ticket1 Title")
            Tickler::Util.should_receive(:print_row).with(:id => 2, :title => "Ticket2 Title")
            Tickler::Util.should_receive(:print_row).with(:id => 3, :title => "Ticket3 Title")
            Tickler::Util.run ['list']
          end
        end
      end

      describe "tickets" do

        describe "with no arguments" do
          describe "with current milestone set" do
            it "lists tickets in the current milestone"
          end

          describe "with no current milestone set" do
            before(:each) do 
              @tickets = 
                [
                  mock(Tickler::Ticket, :id => 1, :title => "Ticket1 Title"),
                  mock(Tickler::Ticket, :id => 2, :title => "Ticket2 Title"),
                  mock(Tickler::Ticket, :id => 3, :title => "Ticket3 Title")
                ]
              Tickler::Ticket.stub!(:find).and_return(@tickets)
            end
                                                               
            it "lists all open tickets, sorted by milestone (where applicable)" do
              Tickler::Util.should_receive(:print_row).with(:id => 1, :title => "Ticket1 Title")
              Tickler::Util.should_receive(:print_row).with(:id => 2, :title => "Ticket2 Title")
              Tickler::Util.should_receive(:print_row).with(:id => 3, :title => "Ticket3 Title")
              Tickler::Util.run ['list']
            end
          end
        end

        describe "with attribute key-value pairs" do 
          before(:each) do 
            @tickets = 
              [
                mock(Tickler::Ticket, :id => 1, :title => "Ticket1 Title"),
                mock(Tickler::Ticket, :id => 2, :title => "Ticket2 Title"),
                mock(Tickler::Ticket, :id => 3, :title => "Ticket3 Title")
              ]
          end

          it "finds tickets which meet the critera" do
            Tickler::Ticket.should_receive(:find).
              with(:all, :status => 'open', :milestone => 'some milestone').
              and_return(@tickets)
            Tickler::Util.run ['list', 'tickets', 'status:open', 'milestone:"some milestone"']
          end
        end
      end

      describe "milestones" do
        describe "with no arguments" do
          before(:each) do 
            @milestones = 
              [
                mock(Tickler::Milestone, :id => 1, :title => "Milestone1 Title"),
                mock(Tickler::Milestone, :id => 2, :title => "Milestone2 Title"),
                mock(Tickler::Milestone, :id => 3, :title => "Milestone3 Title")
              ]
            Tickler::Milestone.stub!(:find).with(:all).and_return(@milestones)
          end
                                                             
          it "lists all milestones" do
            Tickler::Util.should_receive(:print_row).with(:id => 1, :title => "Milestone1 Title")
            Tickler::Util.should_receive(:print_row).with(:id => 2, :title => "Milestone2 Title")
            Tickler::Util.should_receive(:print_row).with(:id => 3, :title => "Milestone3 Title")
            Tickler::Util.run ['list', 'milestones']
          end
        end
      end
    end

    describe "current" do

      describe "ticket" do
        describe "with no arguments"
        describe "with ticket number as argument"
      end

      describe "milestone" do
        describe "with no arguments"
        describe "with milestone number as argument"
      end
      
    end

    describe "close" do

      describe "ticket" do

        it "closes the specified ticket"

      end

    end

  end

end
