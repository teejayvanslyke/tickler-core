module Tickler

  class Ticket

    attr_reader :attributes

    # Initialize this ticket with a set of attributes
    # (repository-specific).
    def initialize(attributes={})
      @attributes = attributes
    end

    # Create a new ticket and push it to the repository.
    def Ticket.create(attributes={})
      @ticket = Ticket.new(attributes)
      Tickler::TaskAdapter.get.save_ticket(@ticket)
      return @ticket
    end

  end

end

