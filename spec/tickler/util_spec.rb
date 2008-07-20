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
                mock(Tickler::Ticket, :title => "Ticket1 Title"),
                mock(Tickler::Ticket, :title => "Ticket2 Title"),
                mock(Tickler::Ticket, :title => "Ticket3 Title")
              ]
            Tickler::Ticket.stub!(:find).and_return(@tickets)
          end
                                                             
          it "lists all open tickets, sorted by milestone (where applicable)" do
            Tickler::Util.should_receive(:print_row).with(:title => "Ticket1 Title")
            Tickler::Util.should_receive(:print_row).with(:title => "Ticket2 Title")
            Tickler::Util.should_receive(:print_row).with(:title => "Ticket3 Title")
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
            it "lists all tickets, sorted by milestone (where applicable)"
          end
        end

      end

      describe "milestones" do

        describe "with no arguments" do
          it "lists all milestones"
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
