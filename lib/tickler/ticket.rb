module Tickler

  class Ticket

    attr_reader :attributes

    # Initialize this ticket with a set of attributes
    # (repository-specific).
    def initialize(attributes={})
      @attributes = attributes
    end

    # Need this because id is special in Ruby.
    def id; attributes[:id] || attributes['id']; end

    def method_missing(name)
      return @attributes[name] if @attributes.has_key?(name)
      return super
    end

    # Create a new ticket and push it to the repository.
    def Ticket.create(attributes={})
      @ticket = Ticket.new(attributes)
      Tickler::TaskAdapter.get.save_ticket(@ticket)
      return @ticket
    end

    # Find tickets in the repository.  Takes the following forms:
    #
    #   Ticket.find(34)     # get the ticket with ID=34, nil if not found.
    #   Ticket.find(:all)   # find all tickets, period.
    #   Ticket.find(:first) # find the first ticket.
    #   Ticket.find(:all, :status => 'open') # find all open tickets.
    def Ticket.find(*args)
      Tickler::TaskAdapter.get.find_tickets(*args)
    end

  end

end

