module Tickler

  # A dummy task adapter for testing purposes.  Echoes a message to the 
  # screen for each action performed, with details.
  class EchoTaskAdapter < Tickler::TaskAdapter
    register_as :echo

    def msg(text)
      puts "EchoTaskAdapter || " + text
    end

    def save_ticket(ticket)
      msg "Saving ticket #{ticket.inspect}"
    end

    def save_milestone(milestone)
      msg "Saving milestone #{milestone.inspect}"
    end
    
  end

end

